#!/usr/bin/env sh

logMessage=""

# Parse input parameters
for parameter in "$@"; do
    case "$parameter" in
    --logfile=*)
        LOGFILE="$(echo "$parameter" | sed 's|^--logfile=||')"
        [ -n "$LOGFILE" ] && export LOGFILE
        ;;
    *)
        logMessage="$logMessage$parameter "
        ;;
    esac
done

# If no logfile it's specified
[ -z "$LOGFILE" ] && exit 1

# If logfile doesn't exist
[ -f "$LOGFILE" ] && {
    directory="$(dirname "$LOGFILE")"
    # If directory doesn't exist
    [ ! -d "$directory" ] && mkdir -p "$directory"
    # Create file
    touch "$LOGFILE"
}

echo "$logMessage" >>"$LOGFILE"
