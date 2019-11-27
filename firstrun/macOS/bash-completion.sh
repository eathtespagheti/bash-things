#!/usr/bin/env bash

bgecho '--- Install bash-completion ---'
brew install bash-completion
gecho 'Load bash-completion'
echo "if [ -f $(brew --prefix)/etc/bash_completion ]; then" >> $HOME/.bash_profile
echo "  . $(brew --prefix)/etc/bash_completion" >> $HOME/.bash_profile
echo "fi" >> $HOME/.bash_profile
gecho 'Reloading .bash_profile'
source $HOME/.bash_profile
echo 'OK'
