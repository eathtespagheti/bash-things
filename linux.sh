#!/usr/bin/env sh
# shellcheck disable=SC1090,SC2155

# ls theme
[ -n "$LS_THEME" ] && load_themes

# load XDG paths
. "$BASHTHINGS_MODULES/XDG_PATHS.sh"

# load bash configuration
. "$BASHTHINGS_MODULES/bash.bash"

# loadkeys
# [ "$(command -v loadkeys)" ] && loadkeys it

# completions
. "$BASHTHINGS_SCRIPTS/load_completions.sh"

# load easymount
. "$BASHTHINGS_FUNCTIONS/easymount.bash"

# load amdgpu variables
#. "$BASHTHINGS_FUNCTIONS/amdgpuPaths.sh" || echo "Loading of amdgpu paths failed"

# trueline settings
. "$BASHTHINGS_MODULES/trueline-settings.bash"
. "$BASHTHINGS_MODULES/trueline/trueline.sh"

# set default make jobs
export MAKEFLAGS="${MAKEFLAGS} -j$(lscpu -b -p=CPU | grep -v '^#' | sort -u | wc -l)"

"$BASHTHINGS_MODULES/autoexec.sh"
