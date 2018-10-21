#!/usr/bin/env bash

echo
bgecho '--- DEV-TOOLS INSTALL ---'

gecho "Install yaourt"
sudo pacman -S yaourt $AUTOYES
echo 'OK'

gecho 'Installing Vivaldi Browser and Atom'
yaourt -S vivaldi atom $AUTOYES
echo 'OK'
