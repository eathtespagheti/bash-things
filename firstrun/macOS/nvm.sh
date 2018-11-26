#!/usr/bin/env bash

bgecho '--- Node Version Manager ---'
gecho 'Sourcing .bashrc in .bash_profile'
echo "source ~/.bashrc" >> $HOME_PATH/$USER/.bash_profile
gecho 'Executing official install script'
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
gecho 'Reloading .bash_profile'
source $HOME_PATH/$USER/.bash_profile
echo 'OK'
gecho 'Installing latest node'
nvm install node
gecho 'Enabling latest node'
nvm use node
