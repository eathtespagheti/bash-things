#!/usr/bin/env sh

case $(uname -s) in
    Linux*)     export OSTYPE=linux-gnu;;
    Darwin*)    export OSTYPE=darwin;;
    CYGWIN*)    export OSTYPE=cygwin;;
    MINGW*)     export OSTYPE=msys;;
    *)          export OSTYPE=UNKNOWN
esac