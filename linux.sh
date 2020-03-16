#!/usr/bin/env bash

# webhook completion
source $bashthingsScripts/webhook/webhook-completion.sh

# enable globstar
shopt -s globstar

# set default make jobs
threads=$(lscpu -b -p=CPU | grep -v '^#' | sort -u | wc -l) # GET how much threads the CPU has
export MAKEFLAGS="${MAKEFLAGS} -j${threads}"

# load easymount
source $bashthingsFunctions/easymount.sh

# BigChameleon specific configuration
source $bashthingsFunctions/checkBigChameleon.sh
if checkBigChameleon; then
    source $bashthingsModules/bigChameleon.sh
fi

# trueline settings
source $bashthingsModules/trueline-settings.sh
source $bashthingsModules/trueline/trueline.sh
