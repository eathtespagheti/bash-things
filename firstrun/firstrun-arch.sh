#!/usr/bin/env sh
# shellcheck disable=SC1090

# Loading variables and XDG_PATHS
. "$BASHTHINGS_FOLDER/modules/variables.sh"
. "$BASHTHINGS_FOLDER/modules/XDG_PATHS.sh"
# Add firstrun bin to path
export PATH="$PATH:$BASHTHINGS_FOLDER/firstrun/bin"

DISTRO='Arch'
bashthingsFirstrun="$BASHTHINGS_FOLDER/firstrun"
bashthingsFirstrunSpecific="$bashthingsFirstrun/$DISTRO"
export PACKAGE_CHECK="pacman -Q"
export PACKAGE_INSTALL="pacman -S"
export AUTOYES="--noconfirm"
ALLTRUE="false"

[ "$1" = "--alltrue" ] && ALLTRUE="true"

# Package update and upgrade
gecho 'Updating and upgrading packages'
# TODO: UNCOMMENT THIS LINE
# sudo pacman -Syu $AUTOYES

# If yay it's not installed
[ ! "$(command -v yay)" ] && {
  gecho 'Install yay'
  git clone https://aur.archlinux.org/yay.git
  cd yay || {
    echo "Error! yay folder not found! Exiting..."
    exit 1
  }
  makepkg -si $AUTOYES
  cd ..
  rm -rf yay
}
# Update autoyes value
export PACKAGE_CHECK="yay -Q"
export PACKAGE_INSTALL="yay -S"
export AUTOYES="$AUTOYES --sudoloop"

# Copy dotfiles
echo
gecho "Copy dotfiles"
copyDotfiles --replace-backups
echo

if [ "$ALLTRUE" = "true" ]; then
  # Enable bash_things
  # If the bashthings file isn't sourced
  grep -q "[^#] *\$BASHTHINGS_FOLDER\/loader.sh" "$HOME/.bashrc" || {
    bgecho 'Enable bash_things in .bashrc'
    {
      echo
      echo "# Customization"
      echo "source ${BASHTHINGS_FOLDER}/loader.sh"
    } >>"$HOME/.bashrc"
  }

  # Case insensitive autocomplete
  "$bashthingsFirstrun/case-insensitive-autocomplete.sh"
  # Improved Graphic Drivers
  customInstaller vulkan-radeon lib32-vulkan-radeon lib32-vulkan-icd-loader mesa
  # Dev-Tools
  "$bashthingsFirstrunSpecific/dev-tools.sh"
  # Broadcom WiFi
  "$bashthingsFirstrunSpecific/broadcom.sh"
  # BMC43142 Bluetooth fix
  "$bashthingsFirstrun/BMC43142.sh"
  # Docker
  "$bashthingsFirstrunSpecific/docker.sh"
  # docker-machine
  "$bashthingsFirstrunSpecific/docker-machine.sh"
  # NVM
  "$bashthingsFirstrunSpecific/nvm.sh"
  # GIT superpush
  "$bashthingsFirstrun/git.sh"
  # screen-sleep
  "$bashthingsFirstrunSpecific/screen-sleep.sh"
  # lolcat
  "$bashthingsFirstrunSpecific/lolcat.sh"
else
  # Enable bash_things
  echo "Enable bash_things? [Y/n] "
  read -r REPLY
  if [ "$REPLY" = "N" ] || [ "$REPLY" = "n" ]; then
    echo
  else
    # Enable bash_things
    # If the bashthings file isn't sourced
    grep -q "[^#] *\$BASHTHINGS_FOLDER\/loader.sh" "$HOME/.bashrc" || {
      bgecho 'Enable bash_things in .bashrc'
      {
        echo
        echo "# Customization"
        echo "source ${BASHTHINGS_FOLDER}/loader.sh"
      } >>"$HOME/.bashrc"
    }
  fi

  # Case insensitive autocomplete
  echo "Enable case insensitive autocomplete? [Y/n] "
  read -r REPLY
  if [ "$REPLY" = "N" ] || [ "$REPLY" = "n" ]; then
    echo
  else
    "$bashthingsFirstrun/case-insensitive-autocomplete.sh"
  fi

  # Improved Graphic Drivers
  echo "Enable Improved Graphic Drivers? [Y/n] "
  read -r REPLY
  if [ "$REPLY" = "N" ] || [ "$REPLY" = "n" ]; then
    echo
  else
    # TODO: Script for enabling 32bit packages in pacman
    customInstaller vulkan-radeon lib32-vulkan-radeon lib32-vulkan-icd-loader mesa
  fi

  # Dev-Tools
  echo "Install Dev-Tools? [Y/n] "
  read -r REPLY
  if [ "$REPLY" = "N" ] || [ "$REPLY" = "n" ]; then
    echo
  else
    "$bashthingsFirstrunSpecific/dev-tools.sh"
  fi

  # Broadcom WiFi
  echo "Install Broadcom WiFi Drivers? [Y/n] "
  read -r REPLY
  if [ "$REPLY" = "N" ] || [ "$REPLY" = "n" ]; then
    echo
  else
    "$bashthingsFirstrunSpecific/broadcom.sh"
  fi

  # BMC43142 Bluetooth fix
  echo "Fix Broadcom BMC43142 Bluetooth? [Y/n] "
  read -r REPLY
  if [ "$REPLY" = "N" ] || [ "$REPLY" = "n" ]; then
    echo
  else
    "$bashthingsFirstrun/BMC43142.sh"
  fi

  # Docker
  echo "Install Docker? [Y/n] "
  read -r REPLY
  if [ "$REPLY" = "N" ] || [ "$REPLY" = "n" ]; then
    echo
  else
    "$bashthingsFirstrunSpecific/docker.sh"
  fi

  # docker-machine
  echo "Install docker-machine? [Y/n] "
  read -r REPLY
  if [ "$REPLY" = "N" ] || [ "$REPLY" = "n" ]; then
    echo
  else
    "$bashthingsFirstrunSpecific/docker-machine.sh"
  fi

  # NVM
  echo "Install NVM? [Y/n] "
  read -r REPLY
  if [ "$REPLY" = "N" ] || [ "$REPLY" = "n" ]; then
    echo
  else
    "$bashthingsFirstrunSpecific/nvm.sh"
  fi

  # GIT superpush
  echo "Enable GIT superpush? [Y/n] "
  read -r REPLY
  if [ "$REPLY" = "N" ] || [ "$REPLY" = "n" ]; then
    echo
  else
    "$bashthingsFirstrun/git.sh"
  fi

  # screen-sleep
  echo "Install screen-sleep? [Y/n] "
  read -r REPLY
  if [ "$REPLY" = "N" ] || [ "$REPLY" = "n" ]; then
    echo
  else
    "$bashthingsFirstrunSpecific/screen-sleep.sh"
  fi

  # lolcat
  "$bashthingsFirstrunSpecific/lolcat.sh"
fi

# echo Done
bgecho 'Done!'

# Final reboot
echo "Reboot system now? [Y/n] "
read -r REPLY
if [ "$REPLY" = "N" ] || [ "$REPLY" = "n" ]; then
  echo
else
  sudo reboot
fi
