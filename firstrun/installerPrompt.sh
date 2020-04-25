#!/usr/bin/env sh

[ ! "$ALLTRUE" = "true" ] && {
    [ -z "$PROMPT_MESSAGE" ] && PROMPT_MESSAGE="Execute \"$*\"?"
    echo "$PROMPT_MESSAGE [Y/n]:"
    read -r REPLY
    if [ "$REPLY" = "N" ] || [ "$REPLY" = "n" ]; then
        echo
    else
        bashthingsLogger "Executing $*"
        "$@"
    fi
    exit
}

bashthingsLogger "Executing $*"
"$@"
