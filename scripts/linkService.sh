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

# Check if folder exist
[ -d "$FOLDER" ] && runWithOrWithoutSudo mkdir -p "$FOLDER"

for service in $inputs; do
    # Check if service exist
    [ ! -f "$BASHTHINGS_SERVICES/$service" ] && echo "Service $service not found" && return 2
    # Check if link exist
    [ -f "$FOLDER/$service" ] && runWithOrWithoutSudo rm "$FOLDER/$service"
    # Make link
    chmod +x "$BASHTHINGS_SERVICES/$service" && runWithOrWithoutSudo ln -s "$BASHTHINGS_SERVICES/$service" "$FOLDER/$service"
done
