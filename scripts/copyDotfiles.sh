#!/usr/bin/env sh

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

for dotfile in $dotfiles; do
    outfile="$outputFolder"/"$dotfile"
    # If dotfile alreaxy exist in destination make a backup
    [ -d "$outfile" ] || [ -f "$outfile" ] && makeBackup "$outfile"
    # Make a link with the original folder
    ln -s "$dotfilesFolder"/"$dotfile" "$outputFolder"/"$dotfile"
done
