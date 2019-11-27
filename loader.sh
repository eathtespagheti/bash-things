#!/usr/bin/env bash

# get colors
# source $HOME_PATH/.bash_things/text/colors.sh

# load variables
source $HOME/.bash_things/scripts/variables.sh

# load custom echos
source $bashthingsFunctions/echo.sh

# docker configuration
source $bashthingsModules/docker.sh

# custom alias
source $bashthingsModules/alias.sh

# trueline settings
source $bashthingsModules/trueline-settings.sh
source $bashthingsFolder/trueline/trueline.sh

# use nano
export EDITOR=nano

# set default make jobs
export MAKEFLAGS='-j4'

# add python user bin to path
export PATH=$PATH:~/.local/bin

# BigChameleon specific configuration
source $bashthingsFunctions/checkBigChameleon.sh
if checkBigChameleon; then
    source $bashthingsModules/bigChameleon.sh
fi
