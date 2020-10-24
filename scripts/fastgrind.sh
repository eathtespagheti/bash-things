#!/usr/bin/env sh

FILENAME="$1"
shift

valgrind --leak-check=full \
    --show-leak-kinds=all \
    --track-origins=yes \
    --verbose \
    --log-file="$FILENAME".log \
    ./"$FILENAME" "$@" &&
    echo &&
    tail -7 "$FILENAME".log
