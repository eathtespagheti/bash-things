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
[ "$1" = "--alltrue" ] && export ALLTRUE="true"
bashthingsLogger "Installing bashthings with $DISTRO script"

# Package update and upgrade
gecho 'Updating and upgrading packages'
bashthingsLogger 'Updating and upgrading packages'
sudo pacman -Syu $AUTOYES

# If yay it's not installed
[ ! "$(command -v yay)" ] && {
  gecho 'Install yay'
  bashthingsLogger 'Install yay'
  git clone https://aur.archlinux.org/yay.git
  cd yay || {
    echo "Error! yay folder not found! Exiting..."
    bashthingsLogger "Error! yay folder not found! Exiting..."
    exit 1
  }
  makepkg -si $AUTOYES
  cd ..
  rm -rf yay && bashthingsLogger "Revmovung yay source folder"
}
# Update autoyes value
export PACKAGE_CHECK="yay -Q"
export PACKAGE_INSTALL="yay -S"
export AUTOYES="$AUTOYES --sudoloop"

# Copy dotfiles
echo
gecho "Copy dotfiles"
bashthingsLogger "Copy dotfiles"
copyDotfiles --replace-backups
echo

# Enable bash_things if isn't already enabled
grep -q "[^#] *\$BASHTHINGS_FOLDER\/loader.sh" "$HOME/.bashrc" || {
  export PROMPT_MESSAGE="Enable bash_things?"
  installerPrompt "$bashthingsFirstrun/enable-bashthings.sh"
}
# Case insensitiv autocomplete if not already enabled
grep -q "^set completion-ignore-case On" "$INPUTRC" || {
  export PROMPT_MESSAGE="Enable case insensitive autocomplete?"
  installerPrompt "$bashthingsFirstrun/case-insensitive-autocomplete.sh"
}
# TODO: Pacman Customization
# export PROMPT_MESSAGE="Enable pacman customizations?"
# installerPrompt "$bashthingsFirstrunSpecific/pacman-customization.sh"
# Improved Graphic Drivers
export PROMPT_MESSAGE="Enable Improved Graphic Drivers?"
# TODO: Script for enabling 32bit packages in pacman
installerPrompt customInstaller amdvlk lib32-amdvlk lib32-vulkan-icd-loader lib32-vulkan-radeon mesa vulkan-radeon
# Custom default apps
export PROMPT_MESSAGE="Install essentials custom apps and utilities?"
installerPrompt customInstaller albert bash-completion brave-bin c-lolcat gst-libav highlight htop nano nvm screen-sleep telegram-desktop transmission-gtk vim visual-studio-code-insiders x264 x265
# Broadcom WiFi
export PROMPT_MESSAGE="Install Broadcom WiFi Drivers?"
installerPrompt "$bashthingsFirstrunSpecific/broadcom.sh"
# BMC43142 Bluetooth fix
export PROMPT_MESSAGE="Fix Broadcom BMC43142 Bluetooth?"
installerPrompt "$bashthingsFirstrun/BMC43142.sh"
# Docker
export PROMPT_MESSAGE="Install Docker?"
installerPrompt "$bashthingsFirstrunSpecific/docker.sh"
# docker-machine
export PROMPT_MESSAGE="Install docker-machine?"
installerPrompt "$bashthingsFirstrunSpecific/docker-machine.sh"
# GIT superpush
export PROMPT_MESSAGE="Enable GIT superpush?"
installerPrompt "$bashthingsFirstrun/git.sh"

# echo Done
bgecho 'Done!'

# Final reboot
export PROMPT_MESSAGE="Reboot system now?"
installerPrompt sudo reboot
