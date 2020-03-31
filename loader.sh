#!/usr/bin/env sh

# load variables
# shellcheck disable=SC1090
. "$HOME"/.bash_things/scripts/variables.sh

# load custom echos
. "$BASHTHINGS_FUNCTIONS"/echo.sh

# docker configuration
[ -f "/etc/bash_completion.d/docker-machine-prompt.bash" ] && "$BASHTHINGS_MODULES"/docker.sh

# custom alias
. "$BASHTHINGS_MODULES"/alias.sh

# add python user bin to path
PYTHON_USER_BIN_PATH=$HOME/.local/bin
export PATH=$PATH:$PYTHON_USER_BIN_PATH

# Check OS
. "$BASHTHINGS_FUNCTIONS"/checkOS.sh
# shellcheck disable=SC2154,SC2039
if [ "$OSTYPE" = "Linux" ]; then
    . "$BASHTHINGS_FOLDER"/linux.sh
elif [ "$OSTYPE" = "Mac" ]; then
    . "$BASHTHINGS_FOLDER"/macOS.sh
else
    . "$BASHTHINGS_FOLDER"/basic.sh
fi
