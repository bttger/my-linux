# my-linux

See the [efistub_fde.md](/efistub_fde.md) file for instructions to install Arch linux without a bootloader and with full disk encryption.

Everything that follows in this readme is not up to date and a WIP.

## TODO

- [x] Use the UEFI as bootloader instead of GRUB
- [x] Encrypt the root partition with LUKS2 and argon2id
- [x] Running manufacturer microcode before booting the kernel
- [x] Hibernation with an (encrypted) swap file
- [ ] Testing different kernels (e.g. the linux-zen kernel)
- [ ] HW acceleration in chromium
- [ ] Automatically update mirror list and sort by speed
- [ ] DNS over TLS


## Install timeshift and make a snapshot before screwing things up
```bash
$ yay timeshift
```

## Settings

- gnome tweaks
  - mouse click emulation -> fingers
- empty file/markdown file vorlagen in /home/templates
- keyboard shortcuts
  - "switch windows" alt+tab
  - "switch applications" super+tab
  - "move to workspace on the left/right" super+alt+left/right
  - "move window to workspace on the left/right" super+shift+left/right
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
- limit the cache size of spotify
  - storage.size=2048 (in /home/tom/.config/spotify/prefs)
  - add exclude rule in timeshift (/home/tom/.cache/spotify/Data/**)

## Gnome extensions

```bash
# install with yay
gnome-shell-extension-gnome-ui-tune-git
gnome-shell-extension-screenshot-git
gnome-shell-extension-clipboard-history

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

## TODO
- librecad
- theme/icons
- zsh theme
  - https://github.com/romkatv/zsh4humans#try-it-in-docker
  - https://github.com/ohmyzsh/ohmyzsh
  - https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet
