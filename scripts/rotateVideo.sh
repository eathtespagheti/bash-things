#!/usr/bin/env sh

printHelp() {
    echo "Usage: rotateVideo [OPTIONS]"
    echo "Rotate a video file."
    echo ""
    echo "Options:"
    echo "  -r ROTATION    Rotation in degrees. Default: 90"
    echo "  -i INPUT       Input file. Default: input.mp4"
    echo "  -o OUTPUT      Output file. Default: inputfilenoextension.rotated.ext"
    echo "  -h             Print this help message and exit"
}

# Using getops parse the following options:
# -r, --rotation -> $ROTATION
# -i, --input -> $INPUT
# -o, --output -> $OUTPUT
# --inplace -> $INPLACE
# -h, --help -> $HELP

getopts "r:i:o:h" OPTION

while [ "$OPTION" != "?" ]; do
    case "$OPTION" in
        r) ROTATION="$OPTARG";;
        i) INPUT="$OPTARG";;
        o) OUTPUT="$OPTARG";;
        h) HELP=1;;
        *) echo "Unknown option";;
    esac
    getopts "r:i:o:h" OPTION
done

# If help is requested, print help and exit
[ "$HELP" = "1" ] && printHelp && exit 0

# If no input is specified, use input.mp4
[ -z "$INPUT" ] && INPUT="input.mp4"

# If no output is specified, use inputfilenoextension.rotated.ext
[ -z "$OUTPUT" ] && OUTPUT=$(basename "$INPUT" | sed "s/\.[^.]*$//").rotated.$(basename "$INPUT" | sed "s/^[^.]*\.//")

# If inplace is specified, use input as output
[ "$INPLACE" = "1" ] && OUTPUT="$INPUT"

# If no rotation is specified, use 90
[ -z "$ROTATION" ] && ROTATION=90

ffmpeg -display_rotation "$ROTATION" -i "$INPUT" -codec copy "$OUTPUT"
