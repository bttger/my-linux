```bash
# Set the console keyboard layout
loadkey de-latin1

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

# Update system clock
timedatectl set-ntp true
timedatectl status

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
cryptsetup luksFormat --type luks2 /dev/<devicePartition>

# Check values chosen by cryptsetup
cryptsetup luksDump /dev/<devicePartition>

# Open the encrypted container
cryptsetup open /dev/<devicePartition> root

# mkfs.ext4 /dev/mapper/root
# mount /dev/mapper/root /mnt

# Format and mount the root partition
mkfs.ext4 /dev/mapper/root
mount /dev/mapper/root /mnt

# Format and mount the EFI system partition (or boot) partition
mkfs.fat -F 32 /dev/<efi_system_partition>
mount --mkdir /dev/<efi_system_partition> /mnt/boot

# Install essential packages
pacstrap /mnt base linux linux-firmware nano efibootmgr

# Generate an fstab file to define how partitions should be mounted into the FS
genfstab -U /mnt >> /mnt/etc/fstab

# Change root into the new system
arch-chroot /mnt

# Set the timezone
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

# Set locales
nano /etc/locale.gen (and uncomment the en.UK utf8 and en.US utf8 lines)
locale-gen
echo $'LANG=en_US.UTF-8\nLC_TIME=en_GB.UTF-8\n' > /etc/locale.conf
echo $'KEYMAP=de-latin1\n' > /etc/vconsole.conf

# Create the hostname file
echo "tom-v330" > /etc/hostname

# Set root password
passwd

# Create a EFI boot entry
efibootmgr --disk /dev/sda --part 1 --create --label "Arch Linux" --loader "\vmlinuz-linux" --unicode "root=PARTUUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX rw initrd=\initramfs-linux.img" --verbose


```
