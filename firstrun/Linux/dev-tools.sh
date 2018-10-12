#!/usr/bin/env bash

echo
bgecho '--- DEV-TOOLS INSTALL ---'

gecho "Adding Vivaldi PPA"
wget -qO- http://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository 'deb http://repo.vivaldi.com/archive/deb/ stable main' -y
echo 'OK'

gecho 'Installing Vivaldi Browser, Atom and snapd'
sudo apt install vivaldi-stable atom snapd -y
echo 'OK'
