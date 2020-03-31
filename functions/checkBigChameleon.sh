#!/usr/bin/env sh

# Return true if the machine it's BigChameleon
checkBigChameleon() {
    [ "$(uname -n)" = "BigChameleon" ] && true || false
}
