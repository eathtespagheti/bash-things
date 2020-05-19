#!/usr/bin/env sh

for parameter in "$@"; do
    tr <"$parameter" '\n' '\r' | sed 's|;LAYER:1\rM140 S[0-9]*|;LAYER:1\rM140 S45|' | tr '\r' '\n' >"tmp$parameter" && mv "tmp$parameter" "$parameter"
done
