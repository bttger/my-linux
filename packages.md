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

# Set up a firewall with iptables (due to Docker not supporting nftables) and firewalld or ufw
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

# Networking
networkmanager
iwd
firewalld
bluez
wireless-regdb

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
xdg-desktop-portal-gnome

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

# My CLI selection
nano
duf
dua-cli
git
gitui
tldr
fd
ripgrep
lsd
bat
btop
smartmontools
nodejs
npm
-yay
-downgrade
-inxi
-ventoy-bin

# My desktop selection
-timeshift
-emote (needs shortcut config)
-onlyoffice-bin
-google-chrome
-insomnia-bin
-vscodium-bin
-vscodium-marketplace
-tor-browser
-spotify
-openlens-bin
firefox
vlc

# My gnome extension selection
gnome-shell-extension-gnome-ui-tune-git
gnome-shell-extension-screenshot-git
gnome-shell-extension-clipboard-history

```
