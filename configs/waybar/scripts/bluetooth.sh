#!/run/current-system/sw/bin/sh

# Check if Bluetooth is soft blocked
if rfkill list bluetooth | grep -q 'Soft blocked: yes'; then
  echo '{"text": "󰂯X", "class": "off"}'
  exit 0
fi

# Get MAC address of connected Bluetooth device
connected_mac=$(bluetoothctl devices Connected | head -n1 | awk '{print $2}')

# If no device is connected
if [ -z "$connected_mac" ]; then
  echo '{"text": "󰂯X", "class": "on"}'
  exit 0
fi

# Get device name
device_name=$(bluetoothctl info "$connected_mac" | grep 'Name:' | head -1 | cut -d' ' -f2-)

# Get battery percentage via upower
battery_path=$(upower -e | grep -i "$connected_mac" | head -1)

if [ -n "$battery_path" ]; then
  battery_percentage=$(upower -i "$battery_path" | grep 'percentage' | awk '{print $2}')
  echo "{\"text\": \"󰂯 $device_name: $battery_percentage\", \"class\": \"on\"}"
else
  echo "{\"text\": \"󰂯 $device_name\", \"class\": \"on\"}"
fi
