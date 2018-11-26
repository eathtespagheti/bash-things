#!/usr/bin/env bash
export HOME_PATH='/Users'
ALLTRUE=false

if [[ $1 = '--alltrue' ]]; then
  ALLTRUE=true
fi

# Loading echo functions
source $HOME_PATH/$USER/.bash_things/firstrun/echo.sh

if [[ $ALLTRUE = true ]]; then
  # Enable bash_things
  bgecho 'Enable bash_things in .bash_profile'
  echo >> $HOME_PATH/$USER/.bash_profile
  echo "# Customization" >> $HOME_PATH/$USER/.bash_profile
  echo "HOME_PATH='${HOME_PATH}'" >> $HOME_PATH/$USER/.bash_profile
  echo "source ${HOME_PATH}/$USER/.bash_things/loader.sh" >> $HOME_PATH/$USER/.bash_profile

  # Case insensitive autocomplete
  $HOME_PATH/$USER/.bash_things/firstrun/case-insensitive-autocomplete.sh
  # Homebrew
  $HOME_PATH/$USER/.bash_things/firstrun/macOS/brew.sh
  # Bash upgrade
  $HOME_PATH/$USER/.bash_things/firstrun/macOS/bash-upgrade.sh
  # bash-completion
  $HOME_PATH/$USER/.bash_things/firstrun/macOS/bash-completion.sh
  # NVM
  $HOME_PATH/$USER/.bash_things/firstrun/macOS/nvm.sh
  # GIT superpush
  $HOME_PATH/$USER/.bash_things/firstrun/git.sh
  # docker-machine autocomplete
  $HOME_PATH/$USER/.bash_things/firstrun/macOS/docker-machine.sh
else
  # Enable bash_things
  read -p "Enable bash_things? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    bgecho 'Enable bash_things in .bash_profile'
    echo >> $HOME_PATH/$USER/.bashrc
    echo "# Customization" >> $HOME_PATH/$USER/.bash_profile
    echo "HOME_PATH='${HOME_PATH}'" >> $HOME_PATH/$USER/.bash_profile
    echo "source ${HOME_PATH}/$USER/.bash_things/loader.sh" >> $HOME_PATH/$USER/.bash_profile
  fi

  # Case insensitive autocomplete
  read -p "Enable case insensitive autocomplete? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/$USER/.bash_things/firstrun/case-insensitive-autocomplete.sh
  fi

  # Homebrew
  read -p "Install Homebrew? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/$USER/.bash_things/firstrun/macOS/brew.sh
  fi

  # Bash upgrade
  read -p "Upgrade bash? (requires homebrew installed) [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/$USER/.bash_things/firstrun/macOS/bash-upgrade.sh
  fi

  # bash-completion
  read -p "Install bash-completion? (requires homebrew installed) [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/$USER/.bash_things/firstrun/macOS/bash-completion.sh
  fi

  # NVM
  read -p "Install NVM? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/$USER/.bash_things/firstrun/macOS/nvm.sh
  fi

  # GIT superpush
  read -p "Enable GIT superpush? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/$USER/.bash_things/firstrun/git.sh
  fi

  # docker-machine autocomplete
  read -p "Enable docker-machine autocomplete? [Y/n] " -n 1 -r
  if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo
  else
    $HOME_PATH/$USER/.bash_things/firstrun/macOS/docker-machine.sh
  fi
fi

# echo Done
bgecho 'Done!'
