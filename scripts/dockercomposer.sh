#!/usr/bin/env sh

# Check dockercomposer folder path
[ -z "$DOCKERCOMPOSER_FOLDER" ] && DOCKERCOMPOSER_FOLDER="$XDG_CONFIG_HOME/dockercomposer"
# Check if $DOCKERCOMPOSER_FOLDER exist
[ ! -d "$DOCKERCOMPOSER_FOLDER" ] && echo "$DOCKERCOMPOSER_FOLDER folder doesn't exist!" && return 2

# Parse input parameters
for parameter in "$@"; do
    if [ -f "$DOCKERCOMPOSER_FOLDER/$parameter" ]; then
        DOCKER_COMPOSE_FILE="$DOCKERCOMPOSER_FOLDER/$parameter $DOCKER_COMPOSE_FILE"
    elif [ "$(echo "$parameter" | awk '{ string=substr($0, 1, 1); print string; }')" = "-" ]; then
        OTHER_ARGS="$parameter$ARGS "
    else
        DOCKER_COMMAND="$parameter$DOCKER_COMMAND "
    fi
done

# Check command
[ -z "$DOCKER_COMMAND" ] && echo "Missing docker-compose command!" && return 1

# Run docker-compose command
for file in $DOCKER_COMPOSE_FILE; do
    eval docker-compose -f "$file" "$DOCKER_COMMAND" "$OTHER_ARGS"
done
