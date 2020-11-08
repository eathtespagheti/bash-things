#!/usr/bin/env sh

runWithOrWithoutSudo() {
    if [ "$needSudo" = "true" ]; then
        eval sudo "$@"
    else
        eval "$@"
    fi
}

FOLDER="/lib/systemd/system"
needSudo="true"

# Parse input parameters
for parameter in "$@"; do
    case "$parameter" in
    --user)
        FOLDER="$XDG_CONFIG_HOME/systemd/user"
        needSudo="false"
        ;;
    *)
        [ -z "$inputs" ] && inputs="$parameter" || inputs="$inputs $parameter"
        ;;
    esac
done


# Check if script exist
[ ! -f "$BASHTHINGS_SERVICES/$1" ] && echo "Service $1 not found" && exit 2

# Check if folder exist
[ -d "$FOLDER" ] && runWithOrWithoutSudo mkdir -p "$FOLDER"

# Check if link exist
[ -f "$FOLDER/$1" ] && runWithOrWithoutSudo rm "$FOLDER/$1"
# Make link
chmod +x "$BASHTHINGS_SERVICES/$1" && runWithOrWithoutSudo ln -s "$BASHTHINGS_SERVICES/$1" "$FOLDER/$1"
