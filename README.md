# my-linux

I use this repository to keep track of the components and instructions that I used to set up my desktop Linux system. It's based on [Arch Linux](https://archlinux.org/) and uses the Gnome shell. I like Arch-based distros like Endeavour OS but unfortunately they only support GRUB which doesn't support my LUKS configuration with argon2id. Also, probably the most important factor for this "project", setting it up all on your own teaches you about Linux, the boot process, etc.

## Features

- [x] Uses the native UEFI as bootloader instead of GRUB (~10-20x faster boot and full LUKS2 support)
- [x] Encrypted root partition with LUKS2 and argon2id (though the initramfs, kernel, and microcode is NOT tamper proof! Secure boot is disabled)
- [x] Runs CPU manufacturer microcode before booting the kernel
- [x] Hibernation with an (encrypted) swap file
- [x] iwd instead of wpa_supplicant
- [x] Testing different kernels (e.g. the linux-zen kernel)
- [x] Automatically updates mirror list and sorts by speed
- [x] HW acceleration in chromium
- [ ] DNS over TLS (not needed anymore, outsourced to my home network DNS server)

## Installation

- Prepare bootable Ventoy USB with `archlinux.iso` and `packages.list` files on it
- Start arch live iso
- Follow the instructions in [efistub_fde.md](/efistub_fde.md)
- After first boot, [install yay](https://github.com/Jguer/yay#installation)
- Install AUR packages with `grep -Po "(?<=^\+\-).+" packages.list | yay -Syu -`

## Settings

- gnome doesn't apply vconsole.conf so the keymap must be set in the settings
- gnome tweaks
  - mouse click emulation -> fingers
- empty file/markdown file vorlagen in /home/templates
- keyboard shortcuts
  - "switch windows" alt+tab
  - "switch applications" super+tab
  - "move to workspace on the left/right" ctrl/super+alt+left/right
  - "move window to workspace on the left/right" super+shift+left/right
  - "maximise window" super+up
  - custom shortcut to open the terminal name command:"kitty" super+t
  - custom shortcut to open emote "emote" ctrl+alt+e
- search: deactivate search for software
- screen lock delay 1 min
- no notifications on lock screen
- acccessibility: disable animations
- configure chrome
  - ublock origin
  - sponsorblock
  - return youtube dislike
  - h264ify
  - bitwarden
  - chrome://flags/#enable-webrtc-pipewire-capturer = enabled # to make screensharing with pipewire work
  - chrome://flags/#enable-gpu-rasterization = enabled
  - chrome://flags/#ozone-platform-hint = auto # to enable native wayland session instead of XWayland compatability layer
- generate ssh key
- upload public key to github
- set up git
  - git config --global user.name "<name>"
  - git config --global user.email "<email>"
  - git config --list
- limit the cache size of spotify
  - storage.size=2048 (in /home/tom/.config/spotify/prefs)
  - add exclude rule in timeshift (/home/tom/.cache/spotify/Data/\*\*)
- disable system-wide global npm packages and enable user-wide packages
  - npm set prefix="$HOME/.local"
- enable automatic mirror list updates
  - sudo nano /etc/xdg/reflector/reflector.config (See the [config](https://github.com/bttger/my-linux/blob/main/reflector.conf))
  - systemctl enable reflector.service
- Clean the package cache
  - sudo paccache -r (or `systemctl enable paccache.timer`)
  - yay -Sc --aur (for AUR packages)
- Zsh config (See [here](https://github.com/bttger/plugin-manager-free-zsh/))

## Automatic Backlight Adjustment

```
# install ddccontrol and make sure the i2c-dev kernel module is installed and loaded
modinfo i2c-dev
lsmod | grep "i2c-dev"

# insert "i2c-dev" in the following file and reboot
sudo nano /etc/modules-load.d/i2c-dev.conf

mkdir -p ~/.config/systemd/user
# copy the systemd files from this repo to the created dir

# let the daemon check for new files
sudo systemctl daemon-reload

# then enable the service and timer
systemctl --user enable auto-backlight.service
systemctl --user enable auto-backlight.timer

# immediately schedule the next run
systemctl --user start auto-backlight.timer
```

## Gnome extensions

```bash
# install with yay
gnome-shell-extension-gnome-ui-tune-git
gnome-shell-extension-clipboard-history

```

## Apps

- google-chrome
- vscodium
  - window.titleBar = custom
- vscodium - marketplace
- docker
  - sudo pacman -Syu docker
  - sudo systemctl start docker.service
  - sudo systemctl enable docker.service
  - sudo usermod -aG docker $USER
  - re-login
- portainer
  - docker volume create portainer_data
  - docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
- tor-browser
- spotify
- openlens-bin
- timeshift
- easyeffects
- onlyoffice

## Backups and snapshots

### Prepare backup/snapshot disk

```
lsblk --fs
sudo fdisk -l /dev/sda
sudo fdisk /dev/sda
sudo cryptsetup luksFormat --type luks2 --label <luks_label> /dev/sda1
sudo cryptsetup open /dev/sda1 <luks_label>
sudo mkfs.ext4 -L <fs_label> /dev/mapper/<luks_label>
mount /dev/mapper/<luks_label> <mount_point>
umount <mount_point>

# wipe disk with zeros
dd if=/dev/zero of=/dev/sdb1 status=progress bs=4M
```

> a fs label can only be 16 bytes max

### Copying stuff to my backup disk with rsync

```
rsync -az --info=progress2 --no-i-r <source_path>/ /<target_path>
```

> if the origin dir ends with trailing slash, it will copy its contents into target dir, otherwise the origin dir will be copied as single folder into target

### Creating a snapshot for my snapshot disks with restic

```
restic init --repo <location>/<repo_name>
restic backup -v -r <location>/<repo_name> <source_dir>

```

> first `cd` to parent dir of the `source_dir` to avoid too many nested dirs in the repository and conflicts in the mounting point path (so that the file change detection of restic works)
