#!/usr/bin/env bash
HOME_PATH='/home'

# Loading echo functions
source $HOME_PATH/$USER/.bash_things/firstrun/echo.sh

# Enable bash_things
bgecho 'Enable bash_things in .bashrc'
echo >> $HOME_PATH/$USER/.bashrc
echo "# Customization" >> $HOME_PATH/$USER/.bashrc
echo "HOME_PATH='${HOME_PATH}'" >> $HOME_PATH/$USER/.bashrc
echo "source ${HOME_PATH}/$USER/.bash_things/loader.sh" >> $HOME_PATH/$USER/.bashrc

# Package update and upgrade
gecho 'Updating and upgrading packages'
sudo apt update
sudo apt upgrade -y

# Gnome 3 hacks
$HOME_PATH/$USER/.bash_things/firstrun/gnome3.sh

# Docker
$HOME_PATH/$USER/.bash_things/firstrun/docker.sh

# echo Done
bgecho 'Done!'
