#!/usr/bin/env sh

# Regex for suspect scrobbles
# "^\"[0-9]*\",\".*\",\".*\",\"\",\"\",\"\",\".*\",\"\""

toDelete="$1"
scrobbles="$2"
tmp="$(cat "$scrobbles")"
nScrobbles="$(echo "$tmp" | wc -l)"
N="$nScrobbles"

while IFS="" read -r line || [ -n "$line" ]; do
    printf "Number of scrobbles: %d\tDeleting artist %s\n" "$nScrobbles" "$line"
    tmp="$(echo "$tmp" | grep -a -v "^\"[0-9]*\",\".*\",$line,\"\",\"\",\"\",\".*\",\"\"")"
    nScrobbles="$(echo "$tmp" | wc -l)"
done < "$toDelete"

echo "$tmp" > "$scrobbles"
cat "$toDelete" >> "$toDelete.bak"
tmp="$(sort "$toDelete.bak" | uniq)"
echo "$tmp" > "$toDelete.bak"
printf "" > "$toDelete"
cut -d ',' -f 4 "$scrobbles" | sort | uniq > bands

N=$((N - nScrobbles))
echo "Process completed, $N scropbbles have been removed"