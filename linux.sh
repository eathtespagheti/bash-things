#!/usr/bin/env bash

# loadkeys
[ "$(command -v loadkeys)" ] && loadkeys it

# webhook completion
# shellcheck disable=SC1090
[ -d "$HOME/.config/webhook" ] && source "$BASHTHINGS_SCRIPTS/webhook/webhook-completion.bash"

# enable globstar
shopt -s globstar

# set default make jobs
# export MAKEFLAGS="${MAKEFLAGS} -j$(lscpu -b -p=CPU | grep -v '^#' | sort -u | wc -l)"

# load easymount
# shellcheck disable=SC1090
source "$BASHTHINGS_FUNCTIONS/easymount.sh"

# BigChameleon specific configuration
# shellcheck disable=SC1090
[ "$(uname -n)" = "BigChameleon" ] && source "$BASHTHINGS_MODULES/bigChameleon.sh"

# trueline settings
# shellcheck disable=SC1090
source "$BASHTHINGS_MODULES/trueline-settings.sh"
# shellcheck disable=SC1090
source "$BASHTHINGS_MODULES/trueline/trueline.sh"
