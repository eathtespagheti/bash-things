#!/usr/bin/env bash

# docker-machine
source /etc/bash_completion.d/docker-machine-prompt.bash

function docker-connect(){
    eval $(docker-machine env "$1")
}
