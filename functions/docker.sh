#!/usr/bin/env bash

function docker-connect(){
    eval $(docker-machine env "$1")
    MACHINE=$(docker-machine active)
}
