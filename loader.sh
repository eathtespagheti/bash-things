#!/usr/bin/env bash

# load variables
source $HOME/.bash_things/scripts/variables.sh

# load custom echos
source $bashthingsFunctions/echo.sh

# docker configuration
[ -f "/etc/bash_completion.d/docker-machine-prompt.bash" ] && source $bashthingsModules/docker.sh

# custom alias
source $bashthingsModules/alias.sh

# add python user bin to path
PYTHON_USER_BIN_PATH=$HOME/.local/bin
export PATH=$PATH:$PYTHON_USER_BIN_PATH

# Check OS
source $bashthingsFunctions/checkOS.sh
if [ "$machine" = "Linux" ]; then
    source $bashthingsFolder/linux.sh
elif [ "$machine" = "Mac" ]; then
    source $bashthingsFolder/macOS.sh
else
    source $bashthingsFolder/basic.sh
fi
