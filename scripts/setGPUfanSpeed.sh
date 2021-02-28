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
[ ! "$(cat /sys/class/drm/$GPU/device/vendor)" = "$amd_vendor" ] && exit 1
device_path="/sys/class/drm/$GPU/device"
# Find HWMON path
HWMON_base="hwmon"
HWMON="$HWMON_base"0
i=1
while [ "$i" -ne 10 ] && [ ! -d "$device_path/hwmon/$HWMON" ]; do
    HWMON="$HWMON_base$i"
    i=$((i + 1))
done
AMDGPU_HWMON="$device_path/hwmon/$HWMON"

[ "$1" = "auto" ] && echo "2" >"$AMDGPU_HWMON/pwm1_enable" && exit

[ "$(cat $AMDGPU_HWMON/pwm1_enable)" != "1" ] && echo "1" >"$AMDGPU_HWMON/pwm1_enable"


fanSpeed="$(echo "$1 * 2.55" | bc -l)"
echo "${fanSpeed%.*}" >"$AMDGPU_HWMON/pwm1"
