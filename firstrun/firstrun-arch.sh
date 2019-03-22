#!/usr/bin/env bash

DISTRO='Arch'
export AUTOYES='--noconfirm'
export PACKAGE_INSTALL='yay -S'
export HOME_PATH=$(getent passwd $USER | cut -d: -f6)
ALLTRUE=false

if [[ $1 = '--alltrue' ]]; then
  ALLTRUE=true
fi

# Loading echo functions
source $HOME_PATH/.bash_things/firstrun/echo.sh

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
  echo >> $HOME_PATH/.bashrc
  echo "# Customization" >> $HOME_PATH/.bashrc
  echo "HOME_PATH='${HOME_PATH}'" >> $HOME_PATH/.bashrc
  echo "source ${HOME_PATH}/.bash_things/loader.sh" >> $HOME_PATH/.bashrc

  # Case insensitive autocomplete
  $HOME_PATH/.bash_things/firstrun/case-insensitive-autocomplete.sh
  # Improved Graphic Drivers
  $HOME_PATH/.bash_things/firstrun/$DISTRO/mesa.sh
  # Dev-Tools
  $HOME_PATH/.bash_things/firstrun/$DISTRO/dev-tools.sh
  # Broadcom WiFi
  $HOME_PATH/.bash_things/firstrun/$DISTRO/broadcom.sh
  # BMC43142 Bluetooth fix
  $HOME_PATH/.bash_things/firstrun/BMC43142.sh
  # Docker
  $HOME_PATH/.bash_things/firstrun/$DISTRO/docker.sh
  # docker-machine
  $HOME_PATH/.bash_things/firstrun/$DISTRO/docker-machine.sh
  # NVM
  $HOME_PATH/.bash_things/firstrun/$DISTRO/nvm.sh
  # GIT superpush
  $HOME_PATH/.bash_things/firstrun/git.sh
else

  # Enable bash_things
  read -p "Enable bash_things? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    bgecho 'Enable bash_things in .bashrc'
    echo >> $HOME_PATH/.bashrc
    echo "# Customization" >> $HOME_PATH/.bashrc
    echo "HOME_PATH='${HOME_PATH}'" >> $HOME_PATH/.bashrc
    echo "source ${HOME_PATH}/.bash_things/loader.sh" >> $HOME_PATH/.bashrc
  fi

  # Case insensitive autocomplete
  read -p "Enable case insensitive autocomplete? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/.bash_things/firstrun/case-insensitive-autocomplete.sh
  fi

  # Improved Graphic Drivers
  read -p "Enable Improved Graphic Drivers? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/.bash_things/firstrun/$DISTRO/mesa.sh
  fi

  # Dev-Tools
  read -p "Install Dev-Tools? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/.bash_things/firstrun/$DISTRO/dev-tools.sh
  fi

  # Broadcom WiFi
  read -p "Install Broadcom WiFi Drivers? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/.bash_things/firstrun/$DISTRO/broadcom.sh
  fi

  # BMC43142 Bluetooth fix
  read -p "Fix Broadcom BMC43142 Bluetooth? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/.bash_things/firstrun/BMC43142.sh
  fi

  # Docker
  read -p "Install Docker? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/.bash_things/firstrun/$DISTRO/docker.sh
  fi

  # docker-machine
  read -p "Install docker-machine? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/.bash_things/firstrun/$DISTRO/docker-machine.sh
  fi

  # NVM
  read -p "Install NVM? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/.bash_things/firstrun/$DISTRO/nvm.sh
  fi

  # GIT superpush
  read -p "Enable GIT superpush? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/.bash_things/firstrun/git.sh
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
