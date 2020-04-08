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
    [ "$(command -v gecho)" ] && gecho "Backup $1 --> $outputFile" || echo "Backup $1 --> $outputFile"
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
        [ "$(command -v recho)" ] && recho "Removing $backup" || echo "Removing $backup"
        delete "$backup"
    done
}

[ "$1" = "-h" ] || [ "$1" = "--help" ] && echo "Run with -b to enable backups, run with -d to delete all backups file in folder at the end, run with -h to show this message" && exit 0

for dotfile in $dotfiles; do
    outfile="$outputFolder"/"$dotfile"
    # If dotfile alreaxy exist in destination make a backup
    [ -d "$outfile" ] || [ -f "$outfile" ] && ([ "$1" = "-b" ] || [ "$1" = "--backup" ] && makeBackup "$outfile" || delete "$outfile")
    # Make a link with the original folder
    echo "Creating link for" "$dotfile" "-->" "$outputFolder"/"$dotfile"
    ln -s "$dotfilesFolder"/"$dotfile" "$outputFolder"/"$dotfile"
done

[ "$1" = "-d" ] || [ "$1" = "--delete-backups" ] && echo && deleteBackups || exit 0
