```bash
# Ensure secure boot is disabled in UEFI settings

# Set the console keyboard layout
loadkeys de-latin1

# Connect to wifi (If it doesn't work, check: https://wiki.archlinux.org/title/Network_configuration/Wireless#Rfkill_caveat)
iwctl
-> iwctl station list
-> iwctl station <station> scan
-> iwctl station <station> get-networks
-> iwctl station <station> connect <network_name>
-> exit
ping archlinux.org

# Verify the boot mode (If dir can be listed without problems, the system got booted in UEFI mode)
ls /sys/firmware/efi/efivars

# start wiping the disk on which the system will be installed (unnecessary for new SSDs)
# check the device name
lsblk

# Check which is the fastest cipher algorithm
cryptsetup benchmark

# Create temporary encrypted container on the whole device
cryptsetup open --type plain --cipher <insert_cipher> -d /dev/urandom /dev/<device> to_be_wiped

# Verify it got mounted
lsblk

# Wipe the container (the encryption cipher is used for secure randomness)
# The bs parameter defines how many bytes to read/write at a time
# (default is 512 bytes which has a lot of overhead;
# 1M is enough to decrease CPU load and guarantee a high throughput;
# see here for more info: http://blog.tdg5.com/tuning-dd-block-size/)
dd if=/dev/zero of=/dev/mapper/to_be_wiped status=progress bs=1M

# Remove the encrypted container
cryptsetup close to_be_wiped

# Verify it got unmounted
lsblk

# Run a secure discard (for SSDs; https://wiki.archlinux.org/title/Solid_state_drive/Memory_cell_clearing#Common_method_with_blkdiscard)
blkdiscard --secure /dev/<device>

# The wiping is now finished

# Partition the disk
fdisk -l
fdisk /dev/<device>
-> g
-> n
-> *Enter*
-> *Enter*
-> +550M
-> n
-> *Enter*
-> *Enter*
-> *Enter*
-> p
-> w

# Create encrypted container for root fs
# TODO try this with --sector-size 4096 instead of the reported 512 bytes from fdisk
cryptsetup luksFormat --type luks2 /dev/<devicePartition>

# Check values chosen by cryptsetup
cryptsetup luksDump /dev/<devicePartition>

# Open the encrypted container
cryptsetup open /dev/<devicePartition> root

# Format and mount the root partition
mkfs.ext4 /dev/mapper/root
mount /dev/mapper/root /mnt

# Format and mount the EFI system partition (or boot) partition
mkfs.fat -F 32 /dev/<efi_system_partition>
mount --mkdir /dev/<efi_system_partition> /mnt/boot

# Install essential packages (with manufacturer microcode, amd-ucode or intel-ucode, optionally replace 'amd' in regex)
grep -Po "^[^-+#~].+|(?<=^~)amd.+|(?<=^\+)[^-].+" packages.list | pacstrap -K /mnt -

# Generate an fstab file to define how partitions should be mounted into the FS
genfstab -U /mnt >> /mnt/etc/fstab

# Change root into the new system
arch-chroot /mnt

# Update the initial ramdisk environment configuration
nano /etc/mkinitcpio.conf
-> HOOKS=(base udev autodetect modconf block keyboard keymap encrypt filesystems resume fsck)
-> COMPRESSION="lz4"
-> COMPRESSION_OPTIONS=(-9)

# Regenerate the initramfs according to the new configuration preset
mkinitcpio -P

# Set the timezone
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

# Set locales
nano /etc/locale.gen (and uncomment the en.GB utf8 and en.US utf8 lines)
locale-gen
echo -e "LANG=en_US.UTF-8\nLC_TIME=en_GB.UTF-8\n" > /etc/locale.conf
echo -e "KEYMAP=de-latin1\n" > /etc/vconsole.conf

# Create the hostname file
echo "<hostname>" > /etc/hostname

# Set root password
passwd

# Create new user
useradd --create-home <username>
passwd <username>

# Create swap file of size 21000 Mebibyte (depending of the size of RAM)
dd if=/dev/zero of=/swapfile bs=1M count=21000 status=progress
chown root:root /swapfile
chmod 0600 /swapfile
mkswap -U clear /swapfile
swapon /swapfile
nano /etc/fstab
# add '/swapfile none swap defaults 0 0' line

# Change the wireless daemon of networkmanager
nano /etc/NetworkManager/conf.d/wifi_backend.conf
-> [device]
-> wifi.backend=iwd
-> wifi.iwd.autoconnect=yes

# Enable display manager, network manager, firewall
systemctl enable gdm.service NetworkManager.service firewalld.service bluetooth.service
systemctl disable wpa_supplicant.service

# Add user to sudoers file (under the root user)
nano /etc/sudoers
-> <username> ALL=(ALL:ALL) ALL

# Get the physical offset of the first block in the swap file
filefrag -v /swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'
# alternatively with 'filefrag -v /swapfile' (first number in row 0)

# Create an EFI boot entry
# (https://wiki.archlinux.org/title/Persistent_block_device_naming)
# (https://wiki.archlinux.org/title/Dm-crypt/Specialties#Discard/TRIM_support_for_solid_state_drives_(SSD))
# You can delete boot entries via `efibootmgr -b <hexValue> -B`
blkid | grep "crypt"
efibootmgr --disk /dev/sda --part 1 --create --label "Arch Linux" --loader "\vmlinuz-linux" --unicode "initrd=\amd-ucode.img initrd=\initramfs-linux.img cryptdevice=UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX:root:allow-discards root=/dev/mapper/root rw resume=/dev/mapper/root resume_offset=<physical_offset>" --verbose

efibootmgr --disk /dev/sda --part 1 --create --label "Arch Linux Zen" --loader "\vmlinuz-linux-zen" --unicode "initrd=\amd-ucode.img initrd=\initramfs-linux-zen.img cryptdevice=UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX:root:allow-discards root=/dev/mapper/root rw resume=/dev/mapper/root resume_offset=<physical_offset>" --verbose

# Exit the chroot session and reboot
exit
reboot
```
