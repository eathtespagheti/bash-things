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
export PATH=$PATH:~/.local/bin

# Set up Node Version Manager
source /usr/share/nvm/init-nvm.sh

# Python virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
source $HOME/.local/bin/virtualenvwrapper.sh

# Check OS
source $bashthingsFunctions/checkOS.sh
if [ "$machine" = "Linux" ]; then
    source $bashthingsFolder/linux.sh
elif [ "$machine" = "Mac" ]; then
    source $bashthingsFolder/macOS.sh
else
    source $bashthingsFolder/basic.sh
fi
