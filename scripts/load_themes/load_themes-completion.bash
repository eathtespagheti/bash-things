#!/usr/bin/env bash

[ -z "$LS_THEMES_FOLDER" ] && LS_THEMES_FOLDER="$XDG_CONFIG_HOME"/load_themes
complete -W "$(ls "$LS_THEMES_FOLDER")" load_themes # Run command for autocomplete
