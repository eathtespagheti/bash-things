#!/bin/sh

# Get the on/off display status
stat=$(busctl --user get-property org.gnome.Mutter.DisplayConfig /org/gnome/Mutter/DisplayConfig org.gnome.Mutter.DisplayConfig PowerSaveMode | cut -d ' ' -f 2)

if [ "$stat" -eq 0 ]; then
    # Turning screen off...
    [ ! "$1" = "--no-warning" ] && echo "Must run this command with --no-warning at the end in order to be effective" && exit 0
    busctl --user set-property org.gnome.Mutter.DisplayConfig /org/gnome/Mutter/DisplayConfig org.gnome.Mutter.DisplayConfig PowerSaveMode i 1
else
    # Turning screen on...
    busctl --user set-property org.gnome.Mutter.DisplayConfig /org/gnome/Mutter/DisplayConfig org.gnome.Mutter.DisplayConfig PowerSaveMode i 0
fi
