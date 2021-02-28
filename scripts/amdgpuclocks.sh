#!/usr/bin/env sh

[ -z "$AMDGPU_PP_OD_CLK" ] || [ -z "$AMDGPU_HWMON" ] || [ -z "$AMDGPU_POWERCAP" ] && {
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
    pp_od_clk_voltage_path="$device_path/pp_od_clk_voltage"
    pp_power_profile_mode_path="$device_path/pp_power_profile_mode"
    power_dpm_force_performance_level_path="$device_path/power_dpm_force_performance_level"

    # Find HWMON path
    HWMON_base="hwmon"
    HWMON="$HWMON_base"0
    i=1
    while [ "$i" -ne 10 ] && [ ! -d "$device_path/hwmon/$HWMON" ]; do
        HWMON="$HWMON_base$i"
        i=$((i + 1))
    done

    AMDGPU_HWMON="$device_path/hwmon/$HWMON"
    AMDGPU_PP_OD_CLK="$pp_od_clk_voltage_path"
    AMDGPU_POWERCAP="$device_path/hwmon/$HWMON/power1_cap"
    AMDGPU_POWER_PROFILE_MODE="$pp_power_profile_mode_path"
    AMDGPU_POWER_DPM_FORCE_PERFORMANCE_LEVEL="$power_dpm_force_performance_level_path"
}

CONFIG_FOLDER_NAME="amdgpuclocks"
[ -z "$XDG_CONFIG_HOME" ] && XDG_CONFIG_HOME="$HOME/.config"
CONFIG_FOLDER="$XDG_CONFIG_HOME/$CONFIG_FOLDER_NAME"

apply_oc() {
    oc="$(echo "$1" | grep "^[^pc] ")"
    power_cap="$(echo "$1" | grep "^[^smp] " | cut -d ' ' -f 2)"
    power_profile="$(echo "$1" | grep "^[^smc] " | cut -d ' ' -f 2)"

    [ -n "$oc" ] && {
        echo "$oc" | while IFS= read -r line; do
            echo "$line" | sudo tee "$AMDGPU_PP_OD_CLK" >/dev/null
        done
    }
    [ -n "$power_cap" ] && echo "$power_cap""000000" | sudo tee "$AMDGPU_POWERCAP" >/dev/null
    [ -n "$power_profile" ] && echo "manual" | sudo tee "$AMDGPU_POWER_DPM_FORCE_PERFORMANCE_LEVEL" >/dev/null && echo "$power_profile" | sudo tee "$AMDGPU_POWER_PROFILE_MODE" >/dev/null
 
    echo "c" | sudo tee "$AMDGPU_PP_OD_CLK" >/dev/null
}

[ -n "$1" ] && [ -f "$CONFIG_FOLDER/$1" ] && fileContent="$(cat "$CONFIG_FOLDER/$1")"
[ -z "$fileContent" ] && echo "Profile not found or empty"
apply_oc "$fileContent"
