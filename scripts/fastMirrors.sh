#!/usr/bin/env sh

curl -s "https://www.archlinux.org/mirrorlist/?country=IT&country=FR&country=ES&protocol=https&ip_version=4" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 0 - >/etc/pacman.d/mirrorlist
