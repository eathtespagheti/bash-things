#!/usr/bin/env bash

[ -z "$DOCKERCOMPOSER_FOLDER" ] && DOCKERCOMPOSER_FOLDER="$XDG_CONFIG_HOME/dockercomposer"
complete -W "$(ls "$DOCKERCOMPOSER_FOLDER")" dockercomposer # Run command for autocomplete