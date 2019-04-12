#!/usr/bin/env bash

MACHINE=''
# get colors
source $HOME_PATH/.bash_things/text/colors.sh
# get fancy
source $HOME_PATH/.bash_things/text/bash_string.sh
# get smart
source $HOME_PATH/.bash_things/functions/docker.sh

# use nano
export EDITOR=nano

# set default make jobs
export MAKEFLAGS='-j8'

# add python user bin to path
export PATH=$PATH:~/.local/bin