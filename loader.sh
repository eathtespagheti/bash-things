#!/usr/bin/env bash

# load variables
source $HOME/.bash_things/scripts/variables.sh

# load custom echos
source $bashthingsFunctions/echo.sh

# docker configuration
source $bashthingsModules/docker.sh

# custom alias
source $bashthingsModules/alias.sh

# use nano
export EDITOR=nano

# add python user bin to path
PYTHON_USER_BIN_PATH=$HOME/.local/bin
export PATH=$PATH:$PYTHON_USER_BIN_PATH

# Set up Node Version Manager
INIT_NVM_PATH=/usr/share/nvm/init-nvm.sh
[ -f "$INIT_NVM_PATH" ] && source $INIT_NVM_PATH

# Python virtualenvwrapper
VIRTUALENVWRAPPER_PATH=$PYTHON_USER_BIN_PATH/virtualenvwrapper.sh
[ -f "$VIRTUALENVWRAPPER_PATH" ] && export WORKON_HOME=$HOME/.virtualenvs && export PROJECT_HOME=$HOME/Projects && source $VIRTUALENVWRAPPER_PATH

# Check OS
source $bashthingsFunctions/checkOS.sh
if [ "$machine" = "Linux" ]; then
    source $bashthingsFolder/linux.sh
elif [ "$machine" = "Mac" ]; then
    source $bashthingsFolder/macOS.sh
else
    source $bashthingsFolder/basic.sh
fi
