#!/usr/bin/env sh
# shellcheck disable=SC2015

dotfilesFolder="$BASHTHINGS_FOLDER"/dotfiles/.config
outputFolder="$XDG_CONFIG_HOME"
dotfiles="$(ls "$dotfilesFolder")"

# Make a backup copy of the file name with an increasing number at the end if the backup already exist
makeBackup() {
    count=0
    outputFile="$1.backup"
    # While output file or output folder exist
    while [ -f "$outputFile" ] || [ -d "$outputFile" ]; do
        outputFile="$1.$count.backup"
        count=$((count + 1))
    done
    mv "$1" "$outputFile"
}

# delete a single backup file
delete() {
    rm -rf "$1"
}

# Delete all backups from folder
deleteBackups() {
    # backups="$(ls "$outputFolder"/*.backup)"
    for backup in "$outputFolder"/*.backup; do
        delete "$backup"
    done
}

[ "$1" = "-h" ] && echo "Run with -n to disable backups, run with -d to delete all backups file in folder at the end, run with -h to show this message" && exit 0

for dotfile in $dotfiles; do
    outfile="$outputFolder"/"$dotfile"
    # If dotfile alreaxy exist in destination make a backup
    [ -d "$outfile" ] || [ -f "$outfile" ] && ([ "$1" = "-n" ] && delete "$outfile" || makeBackup "$outfile")
    # Make a link with the original folder
    ln -s "$dotfilesFolder"/"$dotfile" "$outputFolder"/"$dotfile"
done

[ "$1" = "-d" ] && deleteBackups || exit 0
