#!/usr/bin/env sh
# shellcheck disable=SC2155

themesFolder="$BASHTHINGS_SCRIPTS"/ls_themes/themes
[ -z "$1" ] && theme="$LS_THEME" || theme="$1"
[ -n "$theme" ] && export LS_COLORS="$(cat "$themesFolder"/"$theme")"