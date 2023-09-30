#!/usr/bin/env sh

amd_vendor="0x1002"
cards_path="/sys/class/drm"

# Find AMD GPU
for card in "$cards_path/card"[0-9]; do
    [ ! "$(cat "$card/device/vendor")" = "$amd_vendor" ] && break
done

[ ! "$(cat "$card/device/vendor")" = "$amd_vendor" ] && return 1

device_path="$card/device"
pp_od_clk_voltage_path="$device_path/pp_od_clk_voltage"

# Find HWMON path
HWMON_base="hwmon"
HWMON="$HWMON_base"0
i=1
while [ "$i" -ne 10 ] && [ ! -d "$device_path/hwmon/$HWMON" ]; do
    HWMON="$HWMON_base$i"
    i=$((i + 1))
done

export AMDGPU_HWMON="$device_path/hwmon/$HWMON"
export AMDGPU_PP_OD_CLK="$pp_od_clk_voltage_path"
export AMDGPU_POWERCAP="$device_path/hwmon/$HWMON/power1_cap"
