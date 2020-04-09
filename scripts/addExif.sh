#!/usr/bin/env sh
# shellcheck disable=SC2015,SC1087

# Make a backup copy of the file and remove the original
makeBackup() {
    outputFile="$1.backup"
    [ -d "$outputFile" ] && echo "$outputFile already exist and it's a directory!" && return 1
    [ -f "$outputFile" ] && rm "$outputFile"
    mv "$1" "$outputFile" || return 1
    [ "$(command -v gecho)" ] && gecho "Backup $1 --> $outputFile" || echo "Backup $1 --> $outputFile"
    return 0
}

# backup a file and write the new tag
backupAndWrite() {
    file="$1"
    tag="$2"
    ifd="$3"
    value="$4"
    # Backup picture
    if makeBackup "$file"; then
        exif --tag="$tag" --ifd="$ifd" --set-value="$value" --output="$file" "$file.backup" && rm "$file.backup" || mv "$file.backup" "$file"
    else
        echo "Error making picture backup, skipping..."
    fi
}

# Add a exif tag in a jpeg file
addExifTag() {
    tag="$(echo "$2" | awk '{print $1}')"
    ifd="$(echo "$2" | awk '{print $2}')"
    value="$(echo "$2" | sed "s/$tag[[:space:]]$ifd[[:space:]]//g")"
    # Read tag value
    oldValue="$(exif --tag="$tag" "$1" | grep Value | sed 's/[[:space:]][[:space:]]Value:[[:space:]]//g')"
    # If value doesn't exist
    [ -z "$oldValue" ] && backupAndWrite "$1" "$tag" "$ifd" "$value" && return 0
    # If I'm working on copyright field
    [ "$tag" = "0x8298" ] && return 0
    # If old value it's different than the given one and the preserve parameter it's disabled
    [ "$oldValue" != "$value" ] && [ "$preserveData" = "false" ] && backupAndWrite "$1" "$tag" "$ifd" "$value" && return 0
    return 0
}

# Add an exif value to the exif value list
addExifValueToList() {
    exifValues="$exifValues$1
"
}

# Check if exif is installed
[ ! "$(command -v exif)" ] && echo "You need exif to run this tool!" && echo "Check it on https://sourceforge.net/projects/libexif/"

# Declare variables and default values for globas
inputs=""
preserveData="false"
exifValues=""
[ -z "$FULL_NAME" ] && FULL_NAME="Fabio Sussarellu"
[ -z "$EXIF_ARTIST" ] && EXIF_ARTIST="0x013b 0 $FULL_NAME"
[ -z "$EXIF_COPYRIGHT" ] && EXIF_COPYRIGHT="0x8298 0 Copyright $(date +%Y) $FULL_NAME, all rights reserved."
[ -z "$EXIF_CONTACT" ] && EXIF_CONTACT="0x9286 EXIF sussarellu.fabio@gmail.com"

# Parse input parameters
for parameter in "$@"; do
    case "$parameter" in
    --artist=*)
        EXIF_ARTIST="0x013b 0 $(echo "$parameter" | sed 's/--artist=//g')" # Strip '--artist=' from the parameter
        ;;
    --copyright=*)
        EXIF_COPYRIGHT="0x8298 0 $(echo "$parameter" | sed 's/--copyright=//g')" # Strip '--copyright=' from the parameter
        ;;
    --contact=*)
        EXIF_CONTACT="0x9286 EXIF $(echo "$parameter" | sed 's/--contact=//g')" # Strip '--contact=' from the parameter
        ;;
    --preserve-old-data)
        preserveData="true"
        ;;
    *)
        [ -z "$inputs" ] && inputs="$parameter" || inputs="$inputs $parameter"
        ;;
    esac
done

# Add all the values to the list
addExifValueToList "$EXIF_ARTIST"
addExifValueToList "$EXIF_CONTACT"
addExifValueToList "$EXIF_COPYRIGHT"

# Adjust EXIF on all the pictures
for picture in $inputs; do
    # Check if the file it's a JPEG image
    if [ "$(file "$picture" | awk '{print $2}')" = "JPEG" ]; then
        printf %s "$exifValues" | while IFS= read -r valueString; do
            addExifTag "$picture" "$valueString"
        done
    fi
done

# Quit
exit 0
