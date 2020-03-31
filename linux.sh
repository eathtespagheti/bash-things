#!/usr/bin/env bash

# loadkeys
[ "$(command -v loadkeys)" ] && loadkeys it

# webhook completion
[ -d "$HOME/.webhook" ] && source "$BASHTHINGS_SCRIPTS"/webhook/webhook-completion.sh

# enable globstar
shopt -s globstar

# set default make jobs
# export MAKEFLAGS="${MAKEFLAGS} -j$(lscpu -b -p=CPU | grep -v '^#' | sort -u | wc -l)"

# load easymount
source "$BASHTHINGS_FUNCTIONS"/easymount.sh

# BigChameleon specific configuration
[ "$(uname -n)" = "BigChameleon" ] && source "$BASHTHINGS_MODULES"/bigChameleon.sh

# trueline settings
source $BASHTHINGS_MODULES/trueline-settings.sh
source $BASHTHINGS_MODULES/trueline/trueline.sh
