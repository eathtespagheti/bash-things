#!/usr/bin/env sh

# Assign workdir
dir="$1"
# check for reverse parameter
[ "$dir" = "-r" ] && reverse="true" && dir="$2"

for file in *.mp4; do
    if [ -z "$reverse" ]; then
        newName="$(echo "$file" | sed -rn "s/(.*) ([0-9][0-9])([0-9][0-9])([0-9][0-9][0-9][0-9])(.*)/\4\3\2 - \1\5/p")"
        [ -n "$newName" ] && {
            echo "$file" >"$newName.oldname"
            mv "$file" "$newName"
        }
    else
        # If file exist
        [ -f "$file.oldname" ] && {
            newName="$(cat "$file.oldname")"
            # If newname it's not null
            [ -n "$newName" ] && {
                mv "$file" "$newName"
                rm "$file.oldname"
            }
        }
    fi
done
