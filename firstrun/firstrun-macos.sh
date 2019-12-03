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

# Loading functions
source $bashthingsFunctions/echo.sh
source $bashthingsFunctions/installer.sh

function fastInstall() { # Fast installing command
  installer $PACKAGE_INSTALL $1 ' '
}

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
  fastInstall bash
  # zsh-completion
  fastInstall zsh-completion
  # brew-git
  fastInstall git
  # NVM
  $bashthingsFirstrunSpecific/nvm.sh
  # GIT superpush
  $bashthingsFirstrun/git.sh
  # docker
  fastInstall docker
  # docker-compose
  fastInstall docker-compose
  # docker-machine
  fastInstall docker-machine
  # docker-machine autocomplete
  $bashthingsFirstrunSpecific/docker-machine.sh
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
  read -p "Upgrade bash? [Y/n] " -n 1
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    fastInstall bash
  fi

  # zsh-completion
  read -p "Install zsh-completion? [Y/n] " -n 1
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    fastInstall zsh-completion
  fi

  # brew-git
  read -p "Reinstall git via brew? [Y/n] " -n 1
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    fastInstall git
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

  # docker
  read -p "Install docker? [Y/n] " -n 1
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    fastInstall docker
  fi

  # docker-compose
  read -p "Install docker-compose? [Y/n] " -n 1
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    fastInstall docker-compose
  fi

  # docker-machine
  read -p "Install docker-machine? [Y/n] " -n 1
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    fastInstall docker-machine
  fi

  # docker-machine autocomplete
  read -p "Enable docker-machine autocomplete? [Y/n] " -n 1
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
  else
    $bashthingsFirstrunSpecific/docker-machine.sh
  fi
fi

fastInstall lolcat
fastInstall wget
fastInstall zsh-syntax-highlighting

# echo Done
bgecho 'Done!'
