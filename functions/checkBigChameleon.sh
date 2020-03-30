#!/usr/bin/env bash

# Return true if the machine it's BigChameleon
function checkBigChameleon() {
    [ $(uname -n) = "BigChameleon" ] && true || false
}
