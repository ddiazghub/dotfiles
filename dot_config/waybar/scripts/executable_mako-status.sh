#!/bin/bash
# Mako notification status script for Waybar

# Get mako mode (normal or do-not-disturb)
mode=$(makoctl mode 2>/dev/null)

# Count waiting notifications
count=$(makoctl list 2>/dev/null | grep -c '"app-name"')

# Determine icon and class
if [[ "$mode" == *"do-not-disturb"* ]]; then
    if [ "$count" -gt 0 ]; then
        icon="󰂠 "
        class="dnd-notification"
    else
        icon="󰪓 "
        class="dnd-none"
    fi
else
    if [ "$count" -gt 0 ]; then
        icon="󱅫 "
        class="notification"
    else
        icon="󰂜 "
        class="none"
    fi
fi

# Build tooltip
if [ "$count" -gt 0 ]; then
    tooltip="$count notification(s)"
else
    tooltip="No notifications"
fi

if [[ "$mode" == *"do-not-disturb"* ]]; then
    tooltip="$tooltip (DND)"
fi

# Output JSON for Waybar
echo "{\"text\": \"$icon\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
