#!/bin/sh
yaycache="$(find "$HOME"/.cache/yay -maxdepth 1 -type d | awk '{ print "-c " $1 }' | tail -n +2)"
yayremoved=$(/usr/bin/paccache -ruvk0 $yaycache | sed '/\.cache\/yay/!d' | cut -d \' -f2 | rev | cut -d / -f2- | rev)
[ -z $yayremoved ] || echo "==> Remove all uninstalled package folders" &&
echo $yayremoved | xargs -rt rm -r

yaycache="$(find "$HOME"/.cache/yay -maxdepth 1 -type d | awk '{ print "-c " $1 }' | tail -n +2)"
echo "==> Keep last 2 installed versions"
/usr/bin/paccache -rvk2 -c /var/cache/pacman/pkg $yaycache
