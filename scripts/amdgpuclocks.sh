#!/usr/bin/env sh

apply_oc() {
    oc="$(echo "$1" | grep "^[^fpcd] ")"
    power_cap="$(echo "$1" | grep "^c " | cut -d ' ' -f 2)"
    power_profile="$(echo "$1" | grep "^p " | cut -d ' ' -f 2)"
    fan_speed="$(echo "$1" | grep "^f " | cut -d ' ' -f 2)"

    [ -n "$oc" ] && {
        echo "$oc" | while IFS= read -r line; do
            echo "$line" | tee "$pp_od_clk_voltage_path" >/dev/null
        done
    }
    [ -n "$power_cap" ] && echo "$power_cap""000000" | tee "$AMDGPU_POWERCAP" >/dev/null
    [ -n "$power_profile" ] && echo "manual" | tee "$power_dpm_force_performance_level_path" >/dev/null && echo "$power_profile" | tee "$pp_power_profile_mode_path" >/dev/null
    [ -n "$fan_speed" ] && {
        [ "$fan_speed" = "auto" ] && echo "2" | tee "$hwmon/pwm1_enable" >/dev/null && return
        [ "$(cat $hwmon/pwm1_enable)" != "1" ] && echo "1" | tee "$hwmon/pwm1_enable" >/dev/null
        fan_speed="$(echo "$fan_speed * 2.55" | bc -l)"
        echo "${fan_speed%.*}" | tee "$hwmon/pwm1" >/dev/null
    }

    echo "c" | tee "$pp_od_clk_voltage_path" >/dev/null
}

findHWMON() {
    profileContent="$1"
    for hwmon in $device_path/hwmon/hwmon*; do
        [ -f "$hwmon/power1_cap" ] && AMDGPU_POWERCAP="$hwmon/power1_cap" && apply_oc "$profileContent"
    done
}

findGPU() {
    profileContent="$1"
    device_id="$(echo "$1" | grep "^d " | cut -d ' ' -f 2)"
    cardsList="$(for card in /sys/class/drm/card*; do echo "$card"; done | grep "^.*card[0-9]*$" | tr '\n' ' ')"
    for card in $cardsList; do
        device_path="$card/device"
        [ "$(cat $device_path/vendor)" = "$amd_vendor" ] && [ "$(cat $device_path/device)" = "$device_id" ] && {
            pp_od_clk_voltage_path="$device_path/pp_od_clk_voltage"
            pp_power_profile_mode_path="$device_path/pp_power_profile_mode"
            power_dpm_force_performance_level_path="$device_path/power_dpm_force_performance_level"
            findHWMON "$profileContent"
        }
    done
}

# Variables
amd_vendor="0x1002"
CONFIG_FOLDER_NAME="amdgpuclocks"
[ -z "$XDG_CONFIG_HOME" ] && XDG_CONFIG_HOME="$HOME/.config"
CONFIG_FOLDER="$XDG_CONFIG_HOME/$CONFIG_FOLDER_NAME"
GLOBAL_CONFIG_FOLDER="/etc/$CONFIG_FOLDER_NAME"

for profile in "$@"; do
    unset profileContent
    unset file

    [ -n "$profile" ] && {
        [ "$profile" = "-l" ] && {
            [ -d "$CONFIG_FOLDER" ] && profiles="$(ls --format single-column "$CONFIG_FOLDER")"
            [ -d "$GLOBAL_CONFIG_FOLDER" ] && profiles="$profiles $(ls --format single-column "$GLOBAL_CONFIG_FOLDER")"
            echo "$profiles" | sort | uniq
            exit
        }
        [ -f "$GLOBAL_CONFIG_FOLDER/$profile" ] && file="$GLOBAL_CONFIG_FOLDER/$profile"
        [ -f "$CONFIG_FOLDER/$profile" ] && file="$CONFIG_FOLDER/$profile"
        [ -f "$file" ] && profileContent="$(cat "$file")"
    }

    if [ -z "$profileContent" ]; then
        echo "Profile not found or empty"
    else
        findGPU "$profileContent"
    fi
done
