#!/usr/bin/env sh

dir="${1%/}"

[ -z "$dir" ] && echo "Directory name empty" && exit 1
[ ! -d "$dir" ] && echo "Not a directory" && exit 2

tmpSubvolName="$dir.subvol"
[ -f "$tmpSubvolName" ] || [ -d "$tmpSubvolName" ] && echo "$tmpSubvolName already exist" && exit 3

btrfs subvolume create "$tmpSubvolName"
cp -r --reflink=always "$dir"/* "$tmpSubvolName/."

tmpForDiff="$(mktemp)"
find "$dir" -maxdepth 1 -printf "%f\n" | tail -n +2 >"$tmpForDiff"
diffOut="$(find "$tmpSubvolName" -maxdepth 1 ! -name ".subvol" -printf "%f\n" | tail -n +2 | diff "$tmpForDiff" -)"
rm "$tmpForDiff"

[ -n "$diffOut" ] && echo "Diff not empty:" && echo "$diffOut" && exit 4
echo "All ok"

rm -rf "$dir"
mv "$tmpSubvolName" "$dir"
