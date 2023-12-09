#!/usr/bin/env sh

VIRTUAL_SINK_NAME="BluetoothVirtualSink"
BT_DEVICE_1="bluez_output.7C_C9_5E_B4_51_49.1"
BT_DEVICE_2="bluez_output.18_B9_6E_CD_B3_F8.1"

# Create a virtual sink
pactl list sinks | grep "$VIRTUAL_SINK_NAME" || {
    echo "Creating virtual sink named $VIRTUAL_SINK_NAME"
    pactl load-module module-null-sink media.class=Audio/Sink sink_name="$VIRTUAL_SINK_NAME" channel_map=stereo
}

# Connect the bluetooth devices to the virtual sink

pw-link "$VIRTUAL_SINK_NAME":monitor_FL "$BT_DEVICE_1":playback_FL
pw-link "$VIRTUAL_SINK_NAME":monitor_FR "$BT_DEVICE_1":playback_FR

pw-link "$VIRTUAL_SINK_NAME":monitor_FL "$BT_DEVICE_2":playback_FL
pw-link "$VIRTUAL_SINK_NAME":monitor_FR "$BT_DEVICE_2":playback_FR
