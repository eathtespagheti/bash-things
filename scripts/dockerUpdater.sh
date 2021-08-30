#!/usr/bin/env sh

for image in $(docker image ls | tail -n +2 | cut -d ' ' -f 1 | tr '\n' ' '); do
    docker pull "$image"
done
