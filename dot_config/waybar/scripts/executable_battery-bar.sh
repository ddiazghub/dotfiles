#!/bin/bash
# Battery progress bar script for Waybar

# State file to track previous status for notifications
STATE_FILE="/tmp/waybar-battery-state"

# Get battery info
capacity=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)
status=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -1)

# Exit if no battery
if [ -z "$capacity" ]; then
    echo '{"text": "No Battery", "class": "no-battery"}'
    exit 0
fi

# Read previous state
prev_status=""
prev_class=""
if [ -f "$STATE_FILE" ]; then
    prev_status=$(sed -n '1p' "$STATE_FILE")
    prev_class=$(sed -n '2p' "$STATE_FILE")
fi

# Progress bar settings
bar_length=10
filled=$((capacity * bar_length / 100))
empty=$((bar_length - filled))

# Build the bar using block characters
bar="{"
for ((i=0; i<filled; i++)); do
    bar+="█"
done
for ((i=0; i<empty; i++)); do
    bar+="░"
done
bar+="}"

# Determine class based on status and capacity
if [ "$status" = "Charging" ]; then
    class="charging"
    bar+=" "
elif [ "$status" = "Full" ]; then
    class="full"
elif [ "$capacity" -le 20 ]; then
    class="critical"
elif [ "$capacity" -le 35 ]; then
    class="warning"
else
    class="normal"
fi

bar+="$capacity%"

# Send notifications based on state changes
# 1. Battery warning (entered warning state)
if [ "$class" = "warning" ] && [ "$prev_class" != "warning" ]; then
    notify-send -u normal "Low Battery" "Battery at $capacity%. Consider charging soon."
fi

# 2. Battery critical (entered critical state)
if [ "$class" = "critical" ] && [ "$prev_class" != "critical" ]; then
    notify-send -u critical "Critical Battery" "Battery at $capacity%. Charge now!"
fi

# 3. Charger connected (started charging)
if [ "$status" = "Charging" ] && [ "$prev_status" != "Charging" ]; then
    notify-send -u normal "Charging" "Battery is now charging ($capacity%)"
fi

# 4. Charger disconnected (stopped charging, not full)
if [ "$status" = "Discharging" ] && [ "$prev_status" = "Charging" ]; then
    notify-send -u normal "Unplugged" "Charger disconnected ($capacity%)"
fi

# 5. Battery full
if [ "$status" = "Full" ] && [ "$prev_status" != "Full" ]; then
    notify-send -u normal "Fully Charged" "Battery is fully charged"
fi

# Save current state
echo -e "$status\n$class" > "$STATE_FILE"

echo "{\"text\": \"$bar\", \"tooltip\": \"Battery: $capacity% ($status)\", \"class\": \"$class\", \"percentage\": $capacity}"
