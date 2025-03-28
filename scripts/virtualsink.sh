#!/usr/bin/env sh

VIRTUAL_SINK_NAME="BluetoothVirtualSink"

# Bluetooth adresses
BLUETOOTH_ADDRESSES=""
# Redmi Buds 4
BLUETOOTH_ADDRESSES="7C:C9:5E:B4:51:49 $BLUETOOTH_ADDRESSES"
# Redmi Buds 6 Pro
BLUETOOTH_ADDRESSES="00:BB:43:AA:8F:A6 $BLUETOOTH_ADDRESSES"
# Redmi Buds 5 Pro
BLUETOOTH_ADDRESSES="48:73:CB:A4:D8:6B $BLUETOOTH_ADDRESSES"


# Create a virtual sink
pactl list sinks | grep "$VIRTUAL_SINK_NAME" || {
    echo "Creating virtual sink named $VIRTUAL_SINK_NAME"
    pactl load-module module-null-sink media.class=Audio/Sink sink_name="$VIRTUAL_SINK_NAME" channel_map=stereo
}

# Get list of connected devices
connected_devices="$(bluetoothctl devices Connected | cut -f 2 -d ' ')"

for headphone in $BLUETOOTH_ADDRESSES; do
    # Check if the device is connected
    echo "$connected_devices" | grep "$headphone" || continue
    # Create the device address
    headphone="$(echo "$headphone" | tr ':' '_')"
    bluez_address="$(printf "bluez_output.%s.1" "$headphone")"
    # Connect the bluetooth devices to the virtual sink    
    pw-link "$VIRTUAL_SINK_NAME":monitor_FL "$bluez_address":playback_FL
    pw-link "$VIRTUAL_SINK_NAME":monitor_FR "$bluez_address":playback_FR
done
