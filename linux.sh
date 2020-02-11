#!/usr/bin/env bash

# enable globstar
shopt -s globstar

# set default make jobs
threads=$(lscpu -b -p=CPU | grep -v '^#' | sort -u | wc -l) # GET how much threads the CPU has
export MAKEFLAGS="${MAKEFLAGS} -j${threads}"

# BigChameleon specific configuration
source $bashthingsFunctions/checkBigChameleon.sh
if checkBigChameleon; then
    source $bashthingsModules/bigChameleon.sh
fi

# trueline settings
source $bashthingsModules/trueline-settings.sh
source $bashthingsModules/trueline/trueline.sh
