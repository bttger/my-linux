```bash
# Enable gnome shell and NetworkManager services
systemctl enable gdm.service NetworkManager.service

# Time synchronization
# Either supplied by gnome or via dedicated tool
# systemd-timesyncd (https://wiki.archlinux.org/title/Systemd-timesyncd)
# Service needs to get enabled

# DNS over TLS with Cloudflare
# https://wiki.archlinux.org/title/Systemd-resolved#DNS_over_TLS

# Background service to update the mirror list regularly by status and speed

# Install gnome-shell and common gnome packages
# https://wiki.archlinux.org/title/GNOME#Installation
# Make sure the right drivers got installed for the graphics card

# Set up a firewall with iptables (due to Docker not supporting nftables) and firewalld (or gufw)
# Enable service



```
