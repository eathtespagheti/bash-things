#!/usr/bin/env bash

bgecho '--- Homebrew Package Manager ---'
gecho 'Executing official install script'
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
gecho 'Reloading .bash_profile'
source $HOME/.bash_profile
echo 'OK'
