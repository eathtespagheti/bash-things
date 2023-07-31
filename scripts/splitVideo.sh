#!/usr/bin/env sh

printHelp() {
    echo "Usage: splitVideo [OPTIONS]"
    echo "Split a video file into multiple files of X duration."
    echo ""
    echo "Options:"
    echo "  -d DURATION    Duration time in seconds. Default: 60"
    echo "  -p PARTS       Number of parts. Default: 0"
    echo "  -i INPUT       Input file. Default: input.mp4"
    echo "  -h             Print this help message and exit"
}

# Using getops parse the parameters

getopts "d:p:i:h" OPTION

while [ "$OPTION" != "?" ]; do
    case "$OPTION" in
        d) DURATION="$OPTARG";;
        p) PARTS="$OPTARG";;
        i) INPUT="$OPTARG";;
        h) HELP=1;;
        *) echo "Unknown option";;
    esac
    getopts "d:p:i:h" OPTION
done

# If help is requested, print help and exit
[ "$HELP" = "1" ] && printHelp && exit 0

# If no input is specified, use input.mp4
[ -z "$INPUT" ] && INPUT="input.mp4"

# Video data
LENGTH_ORIGINAL=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$INPUT")
# Round length
LENGTH=$(echo "$LENGTH_ORIGINAL+0.5" | bc | cut -d'.' -f1)
# Calculate 
EXTENSION="$(basename "$INPUT" | sed "s/^[^.]*\.//")"
FILENAME_NO_EXTENSION="$(basename "$INPUT" ".$EXTENSION")"

# If no duration is specified, use 60
[ -z "$DURATION" ] && DURATION=60

[ -z "$PARTS" ] && PARTS=0

# If parts is specified, calculate duration
[ "$PARTS" != "0" ] && DURATION=$(echo "$LENGTH/$PARTS" | bc)

# # If parts is zero, calculate parts
[ "$PARTS" = "0" ] && {
    PARTS=$(echo "$LENGTH/$DURATION" | bc)
}


SPLIT_INDEX=1

while [ "$SPLIT_INDEX" -lt "$PARTS" ]; do
    SS="$(((SPLIT_INDEX-1)*DURATION))"
    ffmpeg -ss "$SS" -i "$INPUT" -t "$DURATION" -map 0 -c copy  "$FILENAME_NO_EXTENSION-$SPLIT_INDEX.$EXTENSION"
    SPLIT_INDEX="$((SPLIT_INDEX+1))"
done

# Elaborate last split
SS="$(((SPLIT_INDEX-1)*DURATION))"
DURATION="$(echo "$LENGTH_ORIGINAL-$SS" | bc)"
ffmpeg -ss "$SS" -i "$INPUT" -t "$DURATION" -map 0 -c copy  "$FILENAME_NO_EXTENSION-$SPLIT_INDEX.$EXTENSION"
