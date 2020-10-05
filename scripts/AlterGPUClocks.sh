#!/usr/bin/env sh

amd_vendor="0x1002"

# Find AMD GPU
GPU_base="card"
GPU="card0"
i=1
while [ "$i" -ne 10 ] && [ ! "$(cat /sys/class/drm/$GPU/device/vendor)" = "$amd_vendor" ]; do
    GPU="$GPU_base$i"
    i=$((i + 1))
done

device_path="/sys/class/drm/$GPU/device"
pp_od_clk_voltage_path="$device_path/pp_od_clk_voltage"

# Find HWMON path
HWMON_base="hwmon"
HWMON="$HWMON_base"0
i=1
while [ "$i" -ne 10 ] && [ ! -d "$device_path/hwmon/$HWMON" ]; do
    HWMON="$HWMON_base$i"
    i=$((i + 1))
done
powercap_path="$device_path/hwmon/$HWMON/power1_cap"

# GPU P-States
echo "s 3 1145 1000" >"$pp_od_clk_voltage_path"
echo "s 4 1215 1000" >"$pp_od_clk_voltage_path"
echo "s 5 1257 1010" >"$pp_od_clk_voltage_path"
echo "s 6 1300 1015" >"$pp_od_clk_voltage_path"
echo "s 7 1366 1020" >"$pp_od_clk_voltage_path"

# VRAM P-States
echo "m 2 2000 900" >"$pp_od_clk_voltage_path"

# Set Max Power to 170W
echo 170000000 >"$powercap_path"

# Apply
echo "c" >"$pp_od_clk_voltage_path"
