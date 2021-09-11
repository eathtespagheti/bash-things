#!/usr/bin/env sh

for config in $(snapper list-configs | tail -n +3 | cut -d ' ' -f 1 | tr '\n' ' '); do
    bgecho "$config"
    snapper -c "$config" list
    printf "\n\n"
done
