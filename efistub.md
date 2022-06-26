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

# Format the partitions
mkfs.fat -F 32 /dev/<efi_system_partition>
mkfs.ext4 /dev/<root_partition>

# Mount the file systems
mount /dev/<root_partition> /mnt
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



```
