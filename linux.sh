#!/usr/bin/env bash

# set default make jobs
export MAKEFLAGS='-j4'

# BigChameleon specific configuration
source $bashthingsFunctions/checkBigChameleon.sh
if checkBigChameleon; then
    source $bashthingsModules/bigChameleon.sh
fi

# trueline settings
source $bashthingsModules/trueline-settings.sh
source $bashthingsModules/trueline/trueline.sh
