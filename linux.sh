#!/usr/bin/env sh
# shellcheck disable=SC1090

# load XDG paths
. "$BASHTHINGS_MODULES/XDG_PATHS.sh"

# load bash configuration
. "$BASHTHINGS_MODULES/bash.bash"

# loadkeys
[ "$(command -v loadkeys)" ] && loadkeys it

# webhook completion
[ -d "$HOME/.config/webhook" ] && . "$BASHTHINGS_SCRIPTS/webhook/webhook-completion.bash"

# load_themes completion
. "$BASHTHINGS_SCRIPTS/load_themes/load_themes-completion.bash"

# load easymount
. "$BASHTHINGS_FUNCTIONS/easymount.bash"

# BigChameleon specific configuration
[ "$(uname -n)" = "BigChameleon" ] && . "$BASHTHINGS_MODULES/bigChameleon.sh"

# trueline settings
. "$BASHTHINGS_MODULES/trueline-settings.bash"
. "$BASHTHINGS_MODULES/trueline/trueline.sh"

# set default make jobs
# export MAKEFLAGS="${MAKEFLAGS} -j$(lscpu -b -p=CPU | grep -v '^#' | sort -u | wc -l)"
