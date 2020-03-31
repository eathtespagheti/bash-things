#!/usr/bin/env bash

# loadkeys
[ $(command -v loadkeys) ] && loadkeys it

# webhook completion
[ -d "$HOME/.webhook" ] && source $bashthingsScripts/webhook/webhook-completion.sh

# enable globstar
shopt -s globstar

# set default make jobs
# export MAKEFLAGS="${MAKEFLAGS} -j$(lscpu -b -p=CPU | grep -v '^#' | sort -u | wc -l)"

# load easymount
source $bashthingsFunctions/easymount.sh

# BigChameleon specific configuration
[ $(uname -n) = "BigChameleon" ] && source $bashthingsModules/bigChameleon.sh

# trueline settings
source $bashthingsModules/trueline-settings.sh
source $bashthingsModules/trueline/trueline.sh
