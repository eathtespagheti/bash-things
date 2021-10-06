 #!/usr/bin/env sh

for song in "$@"; do
    oldfile="$song.no16bit"
    mv "$song" "$oldfile"
    echo "Original moved to $oldfile"
    ffmpeg -i "$oldfile" -sample_fmt s16 -ar 44100 -f flac "$song" && echo "Removing $oldfile" && rm "$oldfile"
done
