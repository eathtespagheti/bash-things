#!/usr/bin/env bash

DISTRO='Manjaro'
export AUTOYES='--noconfirm'
export PACKAGE_INSTALL='yaourt -S'
export HOME_PATH='/home'
ALLTRUE=false

if [[ $1 = '--alltrue' ]]; then
  ALLTRUE=true
fi

# Loading echo functions
source $HOME_PATH/$USER/.bash_things/firstrun/echo.sh

# Package update and upgrade
gecho 'Updating and upgrading packages'
sudo pacman-mirrors --fasttrack 10
sudo pacman -Syyu $AUTOYES

gecho 'Install yaourt'
sudo pacman -S yaourt $AUTOYES

if [[ $ALLTRUE = true ]]; then
  # Enable bash_things
  bgecho 'Enable bash_things in .bashrc'
  echo >> $HOME_PATH/$USER/.bashrc
  echo "# Customization" >> $HOME_PATH/$USER/.bashrc
  echo "HOME_PATH='${HOME_PATH}'" >> $HOME_PATH/$USER/.bashrc
  echo "source ${HOME_PATH}/$USER/.bash_things/loader.sh" >> $HOME_PATH/$USER/.bashrc

  # Improved Graphic Drivers
  $HOME_PATH/$USER/.bash_things/firstrun/$DISTRO/mesa.sh
  # Dev-Tools
  $HOME_PATH/$USER/.bash_things/firstrun/$DISTRO/dev-tools.sh
  # BCM43142 Drivers
  $HOME_PATH/$USER/.bash_things/firstrun/$DISTRO/broadcom.sh
  # Docker
  $HOME_PATH/$USER/.bash_things/firstrun/$DISTRO/docker.sh
  # docker-machine
  $HOME_PATH/$USER/.bash_things/firstrun/$DISTRO/docker-machine.sh
  # NVM
  $HOME_PATH/$USER/.bash_things/firstrun/nvm.sh
  # GIT superpush
  $HOME_PATH/$USER/.bash_things/firstrun/git.sh
else
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

  # Improved Graphic Drivers
  read -p "Enable Improved Graphic Drivers? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/$USER/.bash_things/firstrun/$DISTRO/mesa.sh
  fi

  # Dev-Tools
  read -p "Install Dev-Tools? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/$USER/.bash_things/firstrun/$DISTRO/dev-tools.sh
  fi

  # Broadcom WiFi
  read -p "Install Broadcom WiFi Drivers? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/$USER/.bash_things/firstrun/$DISTRO/broadcom.sh
  fi

  # Docker
  read -p "Install Docker? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/$USER/.bash_things/firstrun/$DISTRO/docker.sh
  fi

  # docker-machine
  read -p "Install docker-machine? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/$USER/.bash_things/firstrun/$DISTRO/docker-machine.sh
  fi

  # NVM
  read -p "Install NVM? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/$USER/.bash_things/firstrun/nvm.sh
  fi

  # GIT superpush
  read -p "Enable GIT superpush? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/$USER/.bash_things/firstrun/git.sh
  fi
fi

# echo Done
bgecho 'Done!'

# Final reboot
read -p "Reboot system now? [Y/n] " -n 1 -r
if [[ $REPLY =~ ^[Nn]$ ]]
then
  echo
else
  sudo reboot
fi
