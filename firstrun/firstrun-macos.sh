#!/usr/bin/env bash

# Loading variables
HOME="/Users/${USER}"
source $HOME/.bash_things/scripts/variables.sh
DISTRO='macOS'
ALLTRUE=false
bashthingsFirstrun=$bashthingsFolder/firstrun
bashthingsFirstrunSpecific=$bashthingsFirstrun/$DISTRO

# Loading echo functions
source $bashthingsFunctions/echo.sh

if [ "$1" = "--alltrue" ]; then
  ALLTRUE=true
fi

if [[ $ALLTRUE == true ]]; then
  # Enable bash_things
  bgecho 'Enable bash_things in .bash_profile'
  echo >>$HOME/.bash_profile
  echo "# Customization" >>$HOME/.bash_profile
  echo "HOME='${HOME}'" >>$HOME/.bash_profile
  echo "source ${bashthingsFolder}/loader.sh" >>$HOME/.bash_profile

  # Case insensitive autocomplete
  $bashthingsFirstrun/case-insensitive-autocomplete.sh
  # Homebrew
  $bashthingsFirstrunSpecific/brew.sh
  # Bash upgrade
  $bashthingsFirstrunSpecific/bash-upgrade.sh
  # bash-completion
  $bashthingsFirstrunSpecific/bash-completion.sh
  # brew-git
  $bashthingsFirstrunSpecific/brew-git.sh
  # NVM
  $bashthingsFirstrunSpecific/nvm.sh
  # GIT superpush
  $bashthingsFirstrun/git.sh
  # docker-machine autocomplete
  $bashthingsFirstrunSpecific/docker-machine.sh
  # lolcat
  $bashthingsFirstrunSpecific/lolcat.sh
else
  # Enable bash_things
  read secondyn -p "Enable bash_things? [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    bgecho 'Enable bash_things in .bash_profile'
    echo >>$HOME/.bashrc
    echo "# Customization" >>$HOME/.bash_profile
    echo "HOME='${HOME}'" >>$HOME/.bash_profile
    echo "source ${bashThingsFolder}/loader.sh" >>$HOME/.bash_profile
  fi

  # Case insensitive autocomplete
  read secondyn -p "Enable case insensitive autocomplete? [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrun/case-insensitive-autocomplete.sh
  fi

  # Homebrew
  read secondyn -p "Install Homebrew? [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/brew.sh
  fi

  # Bash upgrade
  read secondyn -p "Upgrade bash? (requires homebrew installed) [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/bash-upgrade.sh
  fi

  # bash-completion
  read secondyn -p "Install bash-completion? (requires homebrew installed) [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/bash-completion.sh
  fi

  # brew-git
  read secondyn -p "Reinstall git via brew? (requires homebrew installed) [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/brew-git.sh
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

  # docker-machine autocomplete
  read secondyn -p "Enable docker-machine autocomplete? [Y/n] " -n 1 -r </dev/tty
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/docker-machine.sh
  fi

  # lolcat
  $bashthingsFirstrunSpecific/lolcat.sh
fi

# echo Done
bgecho 'Done!'
