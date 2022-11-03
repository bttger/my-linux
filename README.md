# my-linux

I use this repository to keep track of the components and instructions of my desktop Linux system. It's based on [Arch Linux](https://archlinux.org/) and uses the Gnome shell. The goal is to have a simple, secure system that only installs the bare minimum setup and leaves the choice of apps to the user. It even omits the GRUB bootloader which allows much faster decryption of the LUKS2 container and support of the new argon2id key derivation function.

## Features

- [x] Uses the native UEFI as bootloader instead of GRUB (10-30x faster boot and full LUKS2 support)
- [x] Encrypted root partition with LUKS2 and argon2id (though the initramfs, kernel, and microcode is NOT tamper proof! Secure boot is disabled)
- [x] Runs CPU manufacturer microcode before booting the kernel
- [x] Hibernation with an (encrypted) swap file
- [ ] Testing different kernels (e.g. the linux-zen kernel)
- [ ] HW acceleration in chromium
- [ ] Automatically updates mirror list and sorts by speed
- [ ] DNS over TLS

## Installation

- Prepare bootable Ventoy USB with `archlinux.iso` and `packages.list` files on it
- Start arch live iso
- Follow the instructions in [efistub_fde.md](/efistub_fde.md)
- After first boot, [install yay](https://github.com/Jguer/yay#installation)
- Install AUR packages with `grep -Po "(?<=^\+\-).+" packages.list | yay -Syu -`

## Settings

- gnome tweaks
  - mouse click emulation -> fingers
- empty file/markdown file vorlagen in /home/templates
- keyboard shortcuts
  - "switch windows" alt+tab
  - "switch applications" super+tab
  - "move to workspace on the left/right" super+alt+left/right
  - "move window to workspace on the left/right" super+shift+left/right
  - "maximise window" super+up
  - custom shortcut to open the terminal name command:"gnome-terminal" super+t
- search: deactivate search for software
- screen lock delay 1 min
- no notifications on lock screen
- acccessibility: disable animations
- configure chrome
  - ublock origin
  - sponsorblock
  - return youtube dislike
  - bitwarden
- generate ssh key
- upload public key to github
- set up git
  - git config --global user.name "<name>"
  - git config --global user.email "<email>"
  - git config --list
- check if emojis installed || yay noto-fonts-emoji
- chrome: open and set chrome://flags/#enable-webrtc-pipewire-capturer == true
- limit the cache size of spotify
  - storage.size=2048 (in /home/tom/.config/spotify/prefs)
  - add exclude rule in timeshift (/home/tom/.cache/spotify/Data/**)
- disable system-wide global npm packages and enable user-wide packages
  - npm set prefix="$HOME/.local"

## Gnome extensions

```bash
# install with yay
gnome-shell-extension-gnome-ui-tune-git
gnome-shell-extension-screenshot-git
gnome-shell-extension-clipboard-history

Check out:
https://gitlab.gnome.org/jrahmatzadeh/just-perfection
```

## Apps

- google-chrome
- postman-bin / oder insomnia
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
- timeshift (apps installed)
- featherpad (and make default text editor)
- easyeffects
- onlyoffice

## CLI tools
- bat
- gdu
- btop
- lsd
- (nnn) not installed
- gitui
- fd
- ripgrep
- tldr
- ventoy
- smartmontools


## Screensharing

- make screensharing work under wayland
  - pacman -Syu xdg-desktop-portal xdg-desktop-portal-gtk pipewire
  - open chrome://flags/ and set WebRTC via pipewire to enabled
- sudo pacman -Syu --needed base-devel
- yay noisetorch (not needed anymore if using pipewire audio stack)

## audio improvements (replace pulseaudio with pipewire)
- install manjaro-pipewire (this automatically uninstalls all pulseaudio related)
- check audio quality config
- restart PC
- `pactl info` to see current pulse config
- install easyeffects

## emoji picker
- yay emoji picker
- then add a shortcut ctrl+alt+e (necessary under wayland: https://github.com/tom-james-watson/Emote/wiki/Hotkey-In-Wayland)

## Bluetooth config
- endeavourOS has bluetooth not installed by default
- https://discovery.endeavouros.com/category/bluetooth/
- https://wiki.archlinux.org/title/Bluetooth#Auto_power-on_after_boot/resume

## Backups and snapshots

https://wiki.archlinux.org/title/Synchronization_and_backup_programs

- Timeshift (file based increments; uses rsync)
- Restic or Borg (chunk based increments; encrypted repositories)

## Tere

Insert to zsh config (`.zshrc`):

```
tere() {
    local result=$(/path/to/tere "$@")
    [ -n "$result" ] && cd -- "$result"
}
```

## TODO
- theme/icons
- zsh theme
  - https://github.com/romkatv/zsh4humans#try-it-in-docker
  - https://github.com/ohmyzsh/ohmyzsh
  - https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet
