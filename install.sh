#!/usr/bin/env sh

# If $XDG_CONFIG_HOME it's not set
[ -z "$XDG_CONFIG_HOME" ] && XDG_CONFIG_HOME="$HOME/.config"
# If $XDG_CONFIG_HOME doesnìt exist
[ ! -d "$XDG_CONFIG_HOME" ] && mkdir -p "$XDG_CONFIG_HOME"
# If BASHTHINGS_FOLDER it's not set
[ -z "$BASHTHINGS_FOLDER" ] && export BASHTHINGS_FOLDER="$XDG_CONFIG_HOME"/bash_things
export LOGFILE="$HOME/bashthings-install.log"

# If bash things folder doesn't exist
[ ! -d "$BASHTHINGS_FOLDER" ] && {
    echo "Clone bash things"
    git clone https://gitlab.com/eathtespagheti/bash-things.git "$BASHTHINGS_FOLDER"
    echo
}
# "$BASHTHINGS_FOLDER/scripts/bash-things-update.sh"
# echo
echo "Execute firstrun script"
echo
"$BASHTHINGS_FOLDER/firstrun/firstrun.sh" "$@"
