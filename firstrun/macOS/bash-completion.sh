#!/usr/bin/env bash

bgecho '--- Install bash-completion ---'
brew install bash-completion
gecho 'Load bash-completion'
echo "if [ -f $(brew --prefix)/etc/bash_completion ]; then" >> $HOME_PATH/$USER/.bash_profile
echo "  . $(brew --prefix)/etc/bash_completion" >> $HOME_PATH/$USER/.bash_profile
echo "fi" >> $HOME_PATH/$USER/.bash_profile
gecho 'Reloading .bash_profile'
source $HOME_PATH/$USER/.bash_profile
echo 'OK'
