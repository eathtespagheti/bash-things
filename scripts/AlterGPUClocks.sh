#!/usr/bin/env sh

GPU="card1"
HWMON="hwmon4"

# GPU P-States
echo "s 3 1145 1000" >/sys/class/drm/"$GPU"/device/pp_od_clk_voltage
echo "s 4 1215 1000" >/sys/class/drm/"$GPU"/device/pp_od_clk_voltage
echo "s 5 1257 1010" >/sys/class/drm/"$GPU"/device/pp_od_clk_voltage
echo "s 6 1300 1015" >/sys/class/drm/"$GPU"/device/pp_od_clk_voltage
echo "s 7 1366 1020" >/sys/class/drm/"$GPU"/device/pp_od_clk_voltage

# VRAM P-States
echo "m 2 2000 900" >/sys/class/drm/"$GPU"/device/pp_od_clk_voltage

# Set Max Power to 170W
echo 170000000 >/sys/class/drm/"$GPU"/device/hwmon/"$HWMON"/power1_cap

# Apply
echo "c" >/sys/class/drm/"$GPU"/device/pp_od_clk_voltage
