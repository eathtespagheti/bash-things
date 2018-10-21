#!/usr/bin/env bash

echo
bgecho '--- DEV-TOOLS INSTALL ---'

gecho "Install yaourt"
sudo pacman -S yaourt $AUTOYES
echo 'OK'

gecho 'Installing Vivaldi Browser and Atom'
$PACKAGE_INSTALL vivaldi atom $AUTOYES
echo 'OK'
