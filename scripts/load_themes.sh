#!/usr/bin/env sh
# shellcheck disable=SC2155

[ -z "$LS_THEMES_FOLDER" ] && LS_THEMES_FOLDER="$XDG_CONFIG_HOME"/load_themes
[ -z "$1" ] && theme="$LS_THEME" || theme="$1"
[ -n "$theme" ] && export LS_COLORS="$(cat "$LS_THEMES_FOLDER"/"$theme")"