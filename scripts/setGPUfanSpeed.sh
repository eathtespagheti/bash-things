#!/usr/bin/env sh

amd_vendor="0x1002"
fanSpeed="$1"

setSpeed() {
    [ "$fanSpeed" = "auto" ] && echo "2" >"$hwmon/pwm1_enable" && exit 0
    [ "$(cat $hwmon/pwm1_enable)" != "1" ] && echo "1" >"$hwmon/pwm1_enable"
    fanSpeed="$(echo "$1 * 2.55" | bc -l)"
    echo "${fanSpeed%.*}" >"$hwmon/pwm1"
}

findHWMON() {
    profileContent="$1"
    for hwmon in $device_path/hwmon/hwmon*; do
        setSpeed
    done
}

findGPU() {
    device_id="$(echo "$1" | grep "^d " | cut -d ' ' -f 2)"
    cardsList="$(for card in /sys/class/drm/card*; do echo "$card"; done | grep "^.*card[0-9]*$" | tr '\n' ' ')"
    for card in $cardsList; do
        device_path="$card/device"
        [ "$(cat $device_path/vendor)" = "$amd_vendor" ] && [ "$(cat $device_path/device)" = "$device_id" ] && {
            pp_od_clk_voltage_path="$device_path/pp_od_clk_voltage"
            pp_power_profile_mode_path="$device_path/pp_power_profile_mode"
            power_dpm_force_performance_level_path="$device_path/power_dpm_force_performance_level"
            findHWMON
        }
    done
}

findGPU