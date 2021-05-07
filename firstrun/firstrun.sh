#!/usr/bin/env sh

"$BASHTHINGS_FOLDER/functions/checkOS.sh"

case $(uname -s) in
Linux*) "$BASHTHINGS_FOLDER/firstrun/firstrun-arch.sh" "$@" ;;
Darwin*) "$BASHTHINGS_FOLDER/firstrun/firstrun-macos.sh" "$@" ;;
*) echo "Unable to determine Operating System" && return 1 ;;
esac
