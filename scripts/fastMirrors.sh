#!/usr/bin/env sh

curl -s "https://archlinux.org/mirrorlist/?country=IT&country=FR&country=ES&protocol=https&ip_version=4" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 0 - >/etc/pacman.d/mirrorlist
sed -i "1i Server = https://repo.eathtehspagheti.eu" "/etc/pacman.d/mirrorlist"
