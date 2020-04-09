#!/usr/bin/env sh
# shellcheck disable=SC2015

dotfilesFolder="$BASHTHINGS_FOLDER"/dotfiles/.config
outputFolder="$XDG_CONFIG_HOME"
dotfiles="$(ls "$dotfilesFolder")"

# Make a backup copy of the file name with an increasing number at the end if the backup already exist
makeBackup() {
    count=0
    outputFile="$1.backup"

    # Check if replace backups it's enabled
    if [ "$2" = "--replace-backups" ]; then
        # Delete old backups if exist
        [ -f "$outputFile" ] && rm "$outputFile"
        [ -d "$outputFile" ] && rm -rf "$outputFile"
    else
        # Generate new incremental backups
        # While output file or output folder exist
        while [ -f "$outputFile" ] || [ -d "$outputFile" ]; do
            outputFile="$1.$count.backup"
            count=$((count + 1))
        done
    fi

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

# Parse input parameters
for parameter in "$@"; do
    case "$parameter" in
    --help)
        echo "Run with -b to enable backups, add -r to replace already present backups, run with -d to delete all backups file in folder at the end, run with -h to show this message"
        exit 0
        ;;
    -h)
        echo "Run with -b to enable backups, add -r to replace already present backups, run with -d to delete all backups file in folder at the end, run with -h to show this message"
        exit 0
        ;;
    --delete-backups)
        delete="true"
        ;;
    -d)
        delete="true"
        ;;
    --backup)
        backups="true"
        ;;
    -b)
        backups="true"
        ;;
    --replace-bakups)
        replace="true"
        ;;
    -r)
        replace="true"
        ;;
    esac
done

for dotfile in $dotfiles; do
    outfile="$outputFolder"/"$dotfile"
    # If dotfile alreaxy exist in destination make a backup
    [ -d "$outfile" ] || [ -f "$outfile" ] && ([ "$backups" = "true" ] && makeBackup "$outfile" "$replace" || delete "$outfile")
    # Make a link with the original folder
    echo "Creating link for" "$dotfile" "-->" "$outputFolder"/"$dotfile"
    ln -s "$dotfilesFolder"/"$dotfile" "$outputFolder"/"$dotfile"
done

[ "$delete" = "true" ] && echo && deleteBackups || exit 0
