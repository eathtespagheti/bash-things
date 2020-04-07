#!/usr/bin/env sh

# Check command
[ -z "$1" ] && echo "Missing docker-compose command" && exit 1
command=$1 && shift

# Check dockercomposer folder path
[ -z "$DOCKERCOMPOSER_FOLDER" ] && DOCKERCOMPOSER_FOLDER="$XDG_CONFIG_HOME/dockercomposer"

# Check if $DOCKERCOMPOSER_FOLDER exist
[ ! -d "$DOCKERCOMPOSER_FOLDER" ] && echo "$DOCKERCOMPOSER_FOLDER folder doesn't exist!" && exit 2

# Check DOCKERCOMPOSER_FILE parameter
[ -z "$1" ] || [ "$(echo "$1" | awk '{ string=substr($0, 1, 1); print string; }')" = "-" ] && DOCKERCOMPOSER_FILE="$DOCKERCOMPOSER_FOLDER/docker-compose.yaml"
[ -z "$DOCKERCOMPOSER_FILE" ] && DOCKERCOMPOSER_FILE="$DOCKERCOMPOSER_FOLDER/$1" && shift

# Check if DOCKERCOMPOSER_FILE exist
[ ! -f "$DOCKERCOMPOSER_FILE" ] && echo "$DOCKERCOMPOSER_FILE file doesn't exist!" && exit 3

# Run docker-compose command
docker-compose -f "$DOCKERCOMPOSER_FILE" "$command" "$@"
