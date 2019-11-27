#!/usr/bin/env bash

# get colors
# source $HOME_PATH/.bash_things/text/colors.sh

# load variables
source $HOME/.bash_things/scripts/variables.sh 

# docker configuration
source $bashthingsModules/docker.sh

# use nano
export EDITOR=nano

# set default make jobs
export MAKEFLAGS='-j12'

# add python user bin to path
export PATH=$PATH:~/.local/bin

# custom alias
source $bashthingsModules/alias.sh

# trueline settings
source $bashthingsFolder/trueline-settings.sh
source $bashthingsFolder/trueline/trueline.sh
