#!/usr/bin/env bash

# Loading variables
source $HOME/.bash_things/scripts/variables.sh
DISTRO='Arch'
bashthingsFirstrun=$bashthingsFolder/firstrun
bashthingsFirstrunSpecific=$bashthingsFirstrun/$DISTRO
export AUTOYES='--noconfirm'
export PACKAGE_INSTALL='yay -S'
ALLTRUE=false

# Loading echo functions
source $bashthingsFunctions/echo.sh

if [[ $1 = '--alltrue' ]]; then
  ALLTRUE=true
fi

# Package update and upgrade
gecho 'Updating and upgrading packages'
sudo pacman -Syyu $AUTOYES

gecho 'Install yay'
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si $AUTOYES
cd ..
rm -rf yay

if [[ $ALLTRUE = true ]]; then
  # Enable bash_things
  bgecho 'Enable bash_things in .bashrc'
  echo >> $HOME/.bashrc
  echo "# Customization" >> $HOME/.bashrc
  echo "HOME_PATH='${HOME_PATH}'" >> $HOME/.bashrc
  echo "source ${HOME_PATH}/.bash_things/loader.sh" >> $HOME/.bashrc

  # Case insensitive autocomplete
  $HOME/.bash_things/firstrun/case-insensitive-autocomplete.sh
  # Improved Graphic Drivers
  $HOME/.bash_things/firstrun/$DISTRO/mesa.sh
  # Dev-Tools
  $HOME/.bash_things/firstrun/$DISTRO/dev-tools.sh
  # Broadcom WiFi
  $HOME/.bash_things/firstrun/$DISTRO/broadcom.sh
  # BMC43142 Bluetooth fix
  $HOME/.bash_things/firstrun/BMC43142.sh
  # Docker
  $HOME/.bash_things/firstrun/$DISTRO/docker.sh
  # docker-machine
  $HOME/.bash_things/firstrun/$DISTRO/docker-machine.sh
  # NVM
  $HOME/.bash_things/firstrun/$DISTRO/nvm.sh
  # GIT superpush
  $HOME/.bash_things/firstrun/git.sh
  # screen-sleep
  $HOME/.bash_things/firstrun/$DISTRO/screen-sleep.sh
else

  # Enable bash_things
  read -p "Enable bash_things? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    bgecho 'Enable bash_things in .bashrc'
    echo >> $HOME/.bashrc
    echo "# Customization" >> $HOME/.bashrc
    echo "HOME_PATH='${HOME_PATH}'" >> $HOME/.bashrc
    echo "source ${HOME_PATH}/.bash_things/loader.sh" >> $HOME/.bashrc
  fi

  # Case insensitive autocomplete
  read -p "Enable case insensitive autocomplete? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME/.bash_things/firstrun/case-insensitive-autocomplete.sh
  fi

  # Improved Graphic Drivers
  read -p "Enable Improved Graphic Drivers? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME/.bash_things/firstrun/$DISTRO/mesa.sh
  fi

  # Dev-Tools
  read -p "Install Dev-Tools? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME/.bash_things/firstrun/$DISTRO/dev-tools.sh
  fi

  # Broadcom WiFi
  read -p "Install Broadcom WiFi Drivers? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME/.bash_things/firstrun/$DISTRO/broadcom.sh
  fi

  # BMC43142 Bluetooth fix
  read -p "Fix Broadcom BMC43142 Bluetooth? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME/.bash_things/firstrun/BMC43142.sh
  fi

  # Docker
  read -p "Install Docker? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME/.bash_things/firstrun/$DISTRO/docker.sh
  fi

  # docker-machine
  read -p "Install docker-machine? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME/.bash_things/firstrun/$DISTRO/docker-machine.sh
  fi

  # NVM
  read -p "Install NVM? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME/.bash_things/firstrun/$DISTRO/nvm.sh
  fi

  # GIT superpush
  read -p "Enable GIT superpush? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME/.bash_things/firstrun/git.sh
  fi

  # screen-sleep
  read -p "Install screen-sleep? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME/.bash_things/firstrun/$DISTRO/screen-sleep.sh
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
