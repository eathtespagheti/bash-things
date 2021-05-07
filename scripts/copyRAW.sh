#!/usr/bin/env sh

# Check default variables
[ -z "$COPYRAW_BASEDIR" ] && COPYRAW_BASEDIR="/run/media/$USER"
[ -z "$COPYRAW_DCIM_FOLDER" ] && COPYRAW_DCIM_FOLDER="DCIM"
[ -z "$COPYRAW_EXTENSIONS" ] && COPYRAW_EXTENSIONS="arw raw nef dng"
[ -z "$RAW_PICTURES_FOLDER" ] && RAW_PICTURES_FOLDER="$HOME/Pictures/DCIM/RAW"

# Declare source and destination folder
source="$COPYRAW_BASEDIR/$1/$COPYRAW_DCIM_FOLDER/"
destination="$RAW_PICTURES_FOLDER/$1/"

# Check if source DCIM folder exist
[ ! -d "$source" ] && echo "Unable to find $source directory" && return 1

# Check if folder exist, if not create it
[ ! -d "$destination" ] && mkdir -p "$destination"

includes=""
# Generate includes
for extension in $COPYRAW_EXTENSIONS; do
    capitalized=$(echo "$extension" | awk '{ print toupper($1) }')
    includes="$includes --include='*.$extension' --include='*.$capitalized'"
done

# Run rsync
eval rsync -Pamruv --stats --human-readable "$includes" --include='*/' --exclude='*' "$source" "$destination"

# If user asked for disable automount
[ "$2" = "--keep-mount" ] && return 0

# Umount the drive
umount "$COPYRAW_BASEDIR/$1" && gecho "You can now disconnect the drive"
