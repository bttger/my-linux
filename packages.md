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
pacman-contrib
rebuild-detector
reflector

# Display

# Gnome
gnome-shell
power-profiles-daemon

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
downgrade
yay


# My selection


```
