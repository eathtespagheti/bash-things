#!/usr/bin/env sh

target="$PROJECTS_FOLDER/$1"
shift
$EDITOR "$target" "$@"
