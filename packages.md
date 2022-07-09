```bash
# Enable gnome shell and NetworkManager services
systemctl enable gdm.service NetworkManager.service systemd-timesyncd.service

# Time synchronization
# Either supplied by gnome or via systemd-timesyncd
timedatectl set-ntp true
# Validate it's running
timedatectl status

# DNS over TLS with Cloudflare
# https://wiki.archlinux.org/title/Systemd-resolved#DNS_over_TLS

# Background service to update the mirror list regularly by status and speed

# Install gnome-shell and common gnome packages
# https://wiki.archlinux.org/title/GNOME#Installation
# Make sure the right drivers got installed for the graphics card

# Set up a firewall with iptables (due to Docker not supporting nftables) and firewalld (or gufw)
# Enable service

# Base
linux
linux-firmware
base
base-devel
amd-ucode (or intel-ucode)
efibootmgr
pacman-contrib
rebuild-detector
reflector
man-db
man-pages

# Gnome
gdm
gnome-shell
power-profiles-daemon
gedit
gnome-calculator
gnome-control-center
gnome-keyring
gnome-color-manager
gnome-menus
gnome-tweaks
gnome-shell-extensions
gnome-terminal
nautilus
sushi
gthumb

# Networking
networkmanager
iwd
firewalld
bluez
wireless-regdb

# Fonts
freetype2
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
ttf-liberation

# Media
pipewire-alsa
pipewire-jack
pipewire-pulse

# AUR
yay

# My CLI selection
nano
downgrade (aur)
duf
dua-cli
inxi
git
gitui
tldr
fd
ripgrep
lsd
bat
btop
ventoy
smartmontools

# My desktop selection
timeshift (aur)
emote (aur, needs shortcut config)
vlc

```
