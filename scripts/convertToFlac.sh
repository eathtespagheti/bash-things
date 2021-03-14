 #!/usr/bin/env sh

for song in "$@"; do
    extension="${song##*.}"
    echo "Extension it's $extension"
    filenameNoExtension="${song%.$extension}"
    echo "Filename it's $filenameNoExtension"
    out="$filenameNoExtension.flac"
    echo "Output file it's $out"
    
    ffmpeg -i "$song" -f flac "$out"
done
