#!/usr/bin/env sh

# Check if exif is installed
[ ! "$(command -v exif)" ] && echo "You need exif to run this tool!" && echo "Check it on https://sourceforge.net/projects/libexif/"

# Declare variables
inputs=""
[ -z "$EXIF_ARTIST" ] && EXIF_ARTIST="$USER"

# Parse input parameters
for parameter in "$@"; do
    case "$parameter" in
    --artist=*)
        EXIF_ARTIST="$(echo "$parameter" | sed 's/--artist=//g')" # Strip '--artist=' from the parameter
        ;;
    --replace-different)
        replaceDifferent="true"
        ;;
    *)
        [ -z "$inputs" ] && inputs="$parameter" || inputs="$inputs $parameter"
        ;;
    esac
done

# Make a backup copy of the file
makeBackup() {
    outputFile="$1.backup"
    [ -d "$outputFile" ] && echo "$outputFile already exist and it's a directory!" && return 1
    [ -f "$outputFile" ] && rm "$outputFile"
    cp "$1" "$outputFile" || return 1
    [ "$(command -v gecho)" ] && gecho "Backup $1 --> $outputFile" || echo "Backup $1 --> $outputFile"
    return 0
}

# Adjust EXIF on all the pictures
for picture in $inputs; do
    # Check if the file it's a JPEG image
    if [ "$(file "$picture" | awk '{print $2}')" = "JPEG" ]; then
        # Check if the artist field isn't present
        if [ ! "$(exif --tag=Artist "$picture")" ]; then
            if makeBackup "$picture"; then # Backup picture
                exif --tag=Artist --ifd=0 --set-value="$EXIF_ARTIST" --output="$picture" "$picture"
                rm "$picture.backup"
            else
                echo "Error making picture backup, skipping..."
            fi
        else
            echo "Artist field already present in $picture"
            # Check if replace different it's enabled
            [ -n "$replaceDifferent" ] && artistValue="$(exif --tag=Artist "$picture" | grep Value | sed 's/[[:space:]][[:space:]]Value:[[:space:]]//g')"
            # If artist value exist and differ from $EXIF_ARTIST
            if [ -n "$artistValue" ] && [ "$artistValue" != "$EXIF_ARTIST" ]; then
                echo "Replacing artist field"
                if makeBackup "$picture"; then # Backup picture
                    exif --tag=Artist --ifd=0 --set-value="$EXIF_ARTIST" --output="$picture" "$picture"
                    rm "$picture.backup"
                else
                    echo "Error making picture backup, skipping..."
                fi
                unset artistValue
            fi
        fi
        unset artistOut
    fi
done

# Quit
exit 0
