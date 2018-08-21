#!/usr/bin/env bash

# Enable bash_things
echo 'Enable bash_things in .bashrc...'
HOME_PATH='/User'
echo >> $HOME_PATH/$USER/.bashrc
echo "# Customization" >> $HOME_PATH/$USER/.bashrc
echo "HOME_PATH='${HOME_PATH}'" >> $HOME_PATH/$USER/.bashrc
echo "source ${HOME_PATH}/$USER/.bash_things/loader.sh" >> $HOME_PATH/$USER/.bashrc


# Case insensitive auto-complete
echo 'Enabling case insensitive auto-complete...'
echo "set completion-ignore-case On" >> ~/.inputrc

# echo Done
echo 'Done!'
