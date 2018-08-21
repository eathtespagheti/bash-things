#!/usr/bin/env bash

bgecho '--- Node Version Manager ---'
gecho 'Executing official install script'
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
gecho 'Reloading .bashrc'
source $HOME_PATH/$USER/.bashrc
echo 'OK'
gecho 'Installing latest node'
nvm install node
gecho 'Enabling latest node'
nvm use node
