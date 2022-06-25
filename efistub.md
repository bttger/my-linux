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




```
