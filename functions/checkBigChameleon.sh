#!/usr/bin/env bash

# Return true if the machine it's BigChameleon
function checkBigChameleon() {
    machineName=$(uname -n)
    if [ "$machineName" = "BigChameleon" ]; then
        return 0 # True
    else
        return 1 # False
    fi
}
