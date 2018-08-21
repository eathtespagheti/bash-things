#!/usr/bin/env bash
export HOME_PATH='/home'

# Loading echo functions
source $HOME_PATH/$USER/.bash_things/firstrun/echo.sh

# Package update and upgrade
gecho 'Updating and upgrading packages'
sudo apt update
sudo apt upgrade -y

# Enable bash_things
read -p "Enable bash_things? [Y/n] " -n 1 -r
if [[ $REPLY =~ ^[Nn]$ ]]
then
  echo
else
  bgecho 'Enable bash_things in .bashrc'
  echo >> $HOME_PATH/$USER/.bashrc
  echo "# Customization" >> $HOME_PATH/$USER/.bashrc
  echo "HOME_PATH='${HOME_PATH}'" >> $HOME_PATH/$USER/.bashrc
  echo "source ${HOME_PATH}/$USER/.bash_things/loader.sh" >> $HOME_PATH/$USER/.bashrc
fi

# Gnome 3 hacks
read -p "Enable Gnome 3 Hacks? [Y/n] " -n 1 -r
if [[ $REPLY =~ ^[Nn]$ ]]
then
  echo
else
  $HOME_PATH/$USER/.bash_things/firstrun/gnome3.sh
fi

# Docker
read -p "Install Docker? [Y/n] " -n 1 -r
if [[ $REPLY =~ ^[Nn]$ ]]
then
  echo
else
  $HOME_PATH/$USER/.bash_things/firstrun/docker.sh
fi

# echo Done
bgecho 'Done!'
