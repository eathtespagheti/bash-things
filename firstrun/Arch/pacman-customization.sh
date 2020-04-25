#!/usr/bin/env sh

addParameter() {
    # If $1 configuration it's not present
    [ -n "$(sed -n "^$1" "$PACMAN_CONF_FILE")" ] || {
        bashthingsLogger "Adding $1 parameter in $PACMAN_CONF_FILE"
        # If $1 option it's commented
        if [ -n "$(sed -n "/# *$1/p" "$PACMAN_CONF_FILE")" ]; then
            sudo sed -i "s|# *$1|$1|" "$PACMAN_CONF_FILE"
        else
            # Write $1 in the config file
            echo "$1" | sudo tee -a "$PACMAN_CONF_FILE" >/dev/null
        fi
    }
}

# PACMAN_CONF_FILE="/etc/pacman.conf"
PACMAN_CONF_FILE="$HOME/test.conf"

[ ! -f "$PACMAN_CONF_FILE" ] && exit 1 && recho "Conf file for pacman not found" && bashthingsLogger "Conf file for pacman not found"

addParameter "Color"
addParameter "ILoveCandy"
addParameter "\[multilib\]"
