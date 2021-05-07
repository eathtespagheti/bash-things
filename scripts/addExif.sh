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
    # If the output folder isn't specified
    [ -z "$EXIF_OUTPUT_FOLDER" ] && {
        # Backup picture
        if makeBackup "$file"; then
            exif --tag="$tag" --ifd="$ifd" --set-value="$value" --output="$file" "$file.backup" && rm "$file.backup" || mv "$file.backup" "$file"
        else
            echo "Error making picture backup, skipping..."
        fi
    } && return 0
    # If the output folder exist
    exif --tag="$tag" --ifd="$ifd" --set-value="$value" --output="$EXIF_OUTPUT_FOLDER/$file" "$file" && echo "Replace original picture with the edited one" && cp "$EXIF_OUTPUT_FOLDER/$file" "$file" || cp "$file" "$EXIF_OUTPUT_FOLDER/$file"
}

# Add a exif tag in a jpeg file
addExifTag() {
    # If file doesn't exist
    [ ! -f "$1" ] && echo "File $1 doesn't exist, skipping..." && return 1
    # Obtain EXIF data
    tag="$(echo "$2" | awk '{print $1}')"
    ifd="$(echo "$2" | awk '{print $2}')"
    value="$(echo "$2" | sed "s/$tag[[:space:]]$ifd[[:space:]]//g")"
    # Read tag value
    oldValue="$(exif --tag="$tag" "$1" | grep Value | sed 's/[[:space:]][[:space:]]Value:[[:space:]]//g')"
    # If value doesn't exist
    [ -z "$oldValue" ] && backupAndWrite "$1" "$tag" "$ifd" "$value" && return 0
    # If I'm working on copyright field
    [ "$tag" = "0x8298" ] && echo "Updating copyright" && return 0
    # If old value it's different than the given one and the preserve parameter it's disabled
    [ "$oldValue" != "$value" ] && [ "$preserveData" = "false" ] && echo "Tag $tag already exist, but it's value it's incorrect, updating" && backupAndWrite "$1" "$tag" "$ifd" "$value" && return 0
    # If output folder exist
    [ -n "$EXIF_OUTPUT_FOLDER" ] && echo "Picture $1 doesn't need updates, copying directly to the output folder" && mv "$1" "$EXIF_OUTPUT_FOLDER/." && return 0
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
editDetailsExtension="out.pp3"
[ -z "$FULL_NAME" ] && FULL_NAME="Fabio Sussarellu"
[ -z "$EXIF_ARTIST" ] && EXIF_ARTIST="0x013b 0 $FULL_NAME"
[ -z "$EXIF_COPYRIGHT" ] && EXIF_COPYRIGHT="0x8298 0 Copyright $(date +%Y) $FULL_NAME, all rights reserved."
[ -z "$EXIF_CONTACT" ] && EXIF_CONTACT="0x9286 EXIF sussarellu.fabio@gmail.com"
[ -n "$EXIF_OUTPUT_FOLDER" ] && [ ! -d "$EXIF_OUTPUT_FOLDER" ] && mkdir -p "$EXIF_OUTPUT_FOLDER"
PROFILES_FOLDER="$EXIF_OUTPUT_FOLDER/profiles"
[ ! -d "$PROFILES_FOLDER" ] && mkdir -p "$PROFILES_FOLDER"

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
        echo "Working on picture $picture"
        printf %s "$exifValues" | while IFS= read -r valueString; do
            addExifTag "$picture" "$valueString"
        done
        # If output folder exist and picture it's still in the original location
        [ -n "$EXIF_OUTPUT_FOLDER" ] && [ -f "$picture" ] && echo "Deleting processed picture $picture" && rm "$picture" && [ -f "$picture.$editDetailsExtension" ] && echo "Moving editor info file in $PROFILES_FOLDER/$picture.$editDetailsExtension" && mv "$picture.$editDetailsExtension" "$PROFILES_FOLDER/."
        echo
    fi
done

# Quit
return 0
