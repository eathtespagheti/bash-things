#!/usr/bin/env sh

fixDiffTemp="20"
for parameter in "$@"; do
    numberOfLayers="$(grep "LAYER_COUNT" "$parameter")"
    numberOfLayers="${numberOfLayers#;LAYER_COUNT:}"

    originalTemperature="$(grep -m 1 "M140 S[0-9]*" "$parameter")"
    originalTemperature="${originalTemperature#M140 S}"
    fixTemp=$((originalTemperature - fixDiffTemp))

    temperatureChangeLayer=$((numberOfLayers / 10))

    tr <"$parameter" '\n' '\r' | sed "s|;LAYER:$temperatureChangeLayer\rM140 S[0-9]*|;LAYER:$temperatureChangeLayer\r|;s|;LAYER:$temperatureChangeLayer|;LAYER:$temperatureChangeLayer\rM140 S$fixTemp|" | tr '\r' '\n' >"tmp$parameter" && mv "tmp$parameter" "$parameter"
done
