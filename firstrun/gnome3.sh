#!/usr/bin/env bash

# Loading echo functions
source $HOME_PATH/$USER/.bash_things/firstrun/echo.sh

echo
bgecho '--- GNOME 3 Tweaks ---'

# Fix GNOME 3 workspaces
gecho 'Fixing GNOME 3 workspaces'
gsettings set org.gnome.shell.overrides workspaces-only-on-primary false

gecho 'Installing Gnome Tweaks'
sudo apt install gnome-tweak-tool -y
