# my-linux

```bash
$ pacman -Syu && pacman -Sc && pacman -Syu yay
```

## Install timeshift and make a snapshot before fucking things up
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


- add gnome-tweaks firefox extension
  - clipboard indicator (not anymore, rather clipboard history, new development)
  - screenshot tool
  - gnome 4x ui improvements
  - (Bluetooth Quick Connect)
- timeshift (gnome extensions)


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
- layouts app -> settings -> deactivate manjaro branding -> re-login
- tor-browser
- spotify
- lens
- timeshift (apps installed)
- featherpad


- cli tools
  - bat
  - gdu
  - btop++
  - lsd
  - (nnn) not installed
  - gitui
  - fd
  - ripgrep
  - tldr
  - ventoy
- timeshift (cli tools installed)


- configure chrome
  - ublock origin
  - bitwarden
- generate ssh key
- upload public key to github
- set up git
  - git config --global user.name "Tom Boettger"
  - git config --global user.email "t.boettger@live.de"
  - git config --list 
- timeshift (chrome ssh and git configured)


- limit the cache size of spotify
  - storage.size=2048 (in /home/tom/.config/spotify/prefs)
  - add exclude rule in timeshift (/home/tom/.cache/spotify/Data/**)
- timeshift (after spotify config)


- make screensharing work under wayland
  - pacman -Syu xdg-desktop-portal xdg-desktop-portal-gtk pipewire
  - open chrome://flags/ and set WebRTC via pipewire to enabled
- sudo pacman -Syu --needed base-devel
- yay noisetorch (not needed anymore if using pipewire audio stack)

- auto save to 1 minute in preferences of gedit

- yay noto-fonts-emoji


# audio improvements (replace pulseaudio with pipewire)
- install manjaro-pipewire (this automatically uninstalls all pulseaudio related)
- check audio quality config
- restart PC
- `pactl info` to see current pulse config
- install easyeffects

# emoji picker
- yay emoji picker
- then add a shortcut (necessary under wayland: https://github.com/tom-james-watson/Emote/wiki/Hotkey-In-Wayland)

# Bluetooth config
https://wiki.archlinux.org/title/Bluetooth#Auto_power-on_after_boot/resume

TODO
- librecad
- onlyoffice
- theme/icons
- zsh theme
