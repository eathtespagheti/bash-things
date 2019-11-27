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

# Check OS
source $bashthingsFunctions/checkOS.sh
if [ "$machine" = "Linux" ]; then
    source $bashthingsFolder/linux.sh
else
    source $bashthingsFolder/basic.sh
fi
