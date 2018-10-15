#!/usr/bin/env bash

echo
bgecho '--- GNOME 3 Tweaks ---'

gecho 'Installing Gnome Tweaks'
sudo apt install gnome-tweak-tool -y

gecho 'Fixing Multimonitor Workspaces'
gsettings set org.gnome.shell.overrides workspaces-only-on-primary false
