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

if [ "$1" = "--alltrue" ]; then
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

if [[ $ALLTRUE == true ]]; then
  # Enable bash_things
  bgecho 'Enable bash_things in .bashrc'
  echo >>$HOME/.bashrc
  echo "# Customization" >>$HOME/.bashrc
  echo "source ${bashthingsFolder}/loader.sh" >>$HOME/.bashrc

  # Case insensitive autocomplete
  $bashthingsFirstrun/case-insensitive-autocomplete.sh
  # Improved Graphic Drivers
  $bashthingsFirstrunSpecific/mesa.sh
  # Dev-Tools
  $bashthingsFirstrunSpecific/dev-tools.sh
  # Broadcom WiFi
  $bashthingsFirstrunSpecific/broadcom.sh
  # BMC43142 Bluetooth fix
  $bashthingsFirstrun/BMC43142.sh
  # Docker
  $bashthingsFirstrunSpecific/docker.sh
  # docker-machine
  $bashthingsFirstrunSpecific/docker-machine.sh
  # NVM
  $bashthingsFirstrunSpecific/nvm.sh
  # GIT superpush
  $bashthingsFirstrun/git.sh
  # screen-sleep
  $bashthingsFirstrunSpecific/screen-sleep.sh
  # lolcat
  $bashthingsFirstrunSpecific/lolcat.sh
else
  # Enable bash_things
  read secondyn -p "Enable bash_things? [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    # Enable bash_things
    bgecho 'Enable bash_things in .bashrc'
    echo >>$HOME/.bashrc
    echo "# Customization" >>$HOME/.bashrc
    echo "source ${bashthingsFolder}/loader.sh" >>$HOME/.bashrc
  fi

  # Case insensitive autocomplete
  read secondyn -p "Enable case insensitive autocomplete? [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrun/case-insensitive-autocomplete.sh
  fi

  # Improved Graphic Drivers
  read secondyn -p "Enable Improved Graphic Drivers? [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/mesa.sh
  fi

  # Dev-Tools
  read secondyn -p "Install Dev-Tools? [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/dev-tools.sh
  fi

  # Broadcom WiFi
  read secondyn -p "Install Broadcom WiFi Drivers? [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/broadcom.sh
  fi

  # BMC43142 Bluetooth fix
  read secondyn -p "Fix Broadcom BMC43142 Bluetooth? [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrun/BMC43142.sh
  fi

  # Docker
  read secondyn -p "Install Docker? [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/docker.sh
  fi

  # docker-machine
  read secondyn -p "Install docker-machine? [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/docker-machine.sh
  fi

  # NVM
  read secondyn -p "Install NVM? [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/nvm.sh
  fi

  # GIT superpush
  read secondyn -p "Enable GIT superpush? [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrun/git.sh
  fi

  # screen-sleep
  read secondyn -p "Install screen-sleep? [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/screen-sleep.sh
  fi

  # lolcat
  $bashthingsFirstrunSpecific/lolcat.sh
fi

# echo Done
bgecho 'Done!'

# Final reboot
# read secondyn </dev/tty -p "Reboot system now? [Y/n] " -n 1 -r
# if [[ $REPLY =~ ^[Nn]$ ]]; then
#   echo
# else
#   sudo reboot
# fi
