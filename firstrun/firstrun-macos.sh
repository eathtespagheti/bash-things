#!/usr/bin/env zsh

# Loading variables
HOME="/Users/${USER}"
source $HOME/.bash_things/scripts/variables.sh
DISTRO='macOS'
ALLTRUE=false
bashthingsFirstrun=$bashthingsFolder/firstrun
bashthingsFirstrunSpecific=$bashthingsFirstrun/$DISTRO
export PACKAGE_INSTALL='brew install'
rcFile='.zshrc'

# Loading echo functions
source $bashthingsFunctions/echo.sh

# Homebrew
$bashthingsFirstrunSpecific/brew.sh

if [ "$1" = "--alltrue" ]; then
  ALLTRUE=true
fi

if [[ $ALLTRUE == true ]]; then
  # Enable bash_things
  bgecho 'Backup old '$rcFile
  mv $HOME/$rcFile $HOME/$rcFile.backup
  touch $HOME/$rcFile
  bgecho 'Enable bash_things in '$rcFile
  echo "# Customization" >>$HOME/$rcFile
  echo "HOME='${HOME}'" >>$HOME/$rcFile
  echo "source ${bashthingsFolder}/loader.sh" >>$HOME/$rcFile

  # Case insensitive autocomplete
  $bashthingsFirstrun/case-insensitive-autocomplete.sh
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
  # wget
  $bashthingsFirstrunSpecific/wget.sh
  # lolcat
  $bashthingsFirstrunSpecific/lolcat.sh
else
  # Enable bash_things
  read -p "Enable bash_things? [Y/n] " -n 1
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    # Enable bash_things
    bgecho 'Backup old '$rcFile
    mv $HOME/$rcFile $HOME/$rcFile.backup
    touch $HOME/$rcFile
    bgecho 'Enable bash_things in '$rcFile
    echo >>$HOME/$rcFile
    echo "# Customization" >>$HOME/$rcFile
    echo "HOME='${HOME}'" >>$HOME/$rcFile
    echo "source ${bashthingsFolder}/loader.sh" >>$HOME/$rcFile
  fi

  # Case insensitive autocomplete
  read -p "Enable case insensitive autocomplete? [Y/n] " -n 1
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrun/case-insensitive-autocomplete.sh
  fi

  # Bash upgrade
  read -p "Upgrade bash? (requires homebrew installed) [Y/n] " -n 1
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/bash-upgrade.sh
  fi

  # bash-completion
  read -p "Install bash-completion? (requires homebrew installed) [Y/n] " -n 1
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/bash-completion.sh
  fi

  # brew-git
  read -p "Reinstall git via brew? (requires homebrew installed) [Y/n] " -n 1
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/brew-git.sh
  fi

  # NVM
  read -p "Install NVM? [Y/n] " -n 1
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/nvm.sh
  fi

  # GIT superpush
  read -p "Enable GIT superpush? [Y/n] " -n 1
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrun/git.sh
  fi

  # docker-machine autocomplete
  read -p "Enable docker-machine autocomplete? [Y/n] " -n 1
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/docker-machine.sh
  fi

  # wget
  $bashthingsFirstrunSpecific/wget.sh

  # lolcat
  $bashthingsFirstrunSpecific/lolcat.sh
fi

# echo Done
bgecho 'Done!'
