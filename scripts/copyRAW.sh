#!/usr/bin/env sh

# Check default variables
[ -z "$COPYRAW_BASEDIR" ] && COPYRAW_BASEDIR="/run/media/$USER"
[ -z "$COPYRAW_DCIM_FOLDER" ] && COPYRAW_DCIM_FOLDER="DCIM"
[ -z "$RAW_PICTURES_FOLDER" ] && RAW_PICTURES_FOLDER="$HOME/Pictures/DCIM/RAW"

# Declare source and destination folder
source="$COPYRAW_BASEDIR/$1/$COPYRAW_DCIM_FOLDER/"
destination="$RAW_PICTURES_FOLDER/$1/"

# Check if source DCIM folder exist
[ ! -d "$source" ] && echo "Unable to find $source directory" && exit 1

# Check if folder exist, if not create it
[ ! -d "$destination" ] && mkdir -p "$destination"

# Run rsync
rsync -Pamruv --stats --human-readable --include='*.nef' --include='*.NEF' --include='*.ARW' --include='*.arw' --include='*/' --exclude='*' "$source" "$destination"

# If user asked for disable automount
[ "$2" = "-keep-mount" ] && exit 0

# Umount the drive
umount "$COPYRAW_BASEDIR/$1" && echo "You can now disconnect the drive"
