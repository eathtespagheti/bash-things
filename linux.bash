#!/usr/bin/env bash

# load XDG paths
# shellcheck disable=SC1090
source "$BASHTHINGS_MODULES/XDG_PATHS.sh"

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
source "$BASHTHINGS_FUNCTIONS/easymount.bash"

# BigChameleon specific configuration
# shellcheck disable=SC1090
[ "$(uname -n)" = "BigChameleon" ] && source "$BASHTHINGS_MODULES/bigChameleon.sh"

# trueline settings
# shellcheck disable=SC1090
source "$BASHTHINGS_MODULES/trueline-settings.bash"
# shellcheck disable=SC1090
source "$BASHTHINGS_MODULES/trueline/trueline.sh"
