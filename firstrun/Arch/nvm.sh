#!/usr/bin/env bash

bgecho '--- Node Version Manager ---'
gecho 'Install NVM'
$PACKAGE_INSTALL nvm $AUTOYES
gecho 'Reloading .bashrc'
source $HOME/.bashrc
echo 'OK'
gecho 'Installing latest node'
nvm install node
gecho 'Enabling latest node'
nvm use node
