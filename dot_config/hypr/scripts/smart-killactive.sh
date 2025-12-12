#!/bin/bash

# Get the current workspace ID and initial client count
CURRENT_WS=$(hyprctl activeworkspace -j | jq -r '.id')
INITIAL_COUNT=$(hyprctl clients -j | jq --arg ws "$CURRENT_WS" '[.[] | select(.workspace.id == ($ws | tonumber))] | length')

# If no clients in current workspace, show powermenu
if [ "$INITIAL_COUNT" -eq 0 ]; then
    . ~/.config/rofi/powermenu/powermenu.sh 4
    exit 0
fi

# Kill the active window
hyprctl dispatch killactive

# Wait for the client count to decrease (with timeout)
TIMEOUT=30  # 3 seconds max (30 * 0.1s)
COUNTER=0
CLIENT_COUNT=$INITIAL_COUNT

while [ "$CLIENT_COUNT" -ge "$INITIAL_COUNT" ] && [ $COUNTER -lt $TIMEOUT ]; do
    sleep 0.1
    CLIENT_COUNT=$(hyprctl clients -j | jq --arg ws "$CURRENT_WS" '[.[] | select(.workspace.id == ($ws | tonumber))] | length')
    COUNTER=$((COUNTER + 1))
done

# If there are clients in the current workspace, we're done
if [ "$CLIENT_COUNT" -gt 0 ]; then
    exit 0
fi

# No clients in current workspace, find the highest numbered workspace with clients
HIGHEST_WS=$(hyprctl clients -j | jq -r '[.[].workspace.id] | unique | sort | reverse | .[0]')

# Switch to the highest numbered workspace with clients
if [ -n "$HIGHEST_WS" ] && [ "$HIGHEST_WS" != "null" ]; then
    hyprctl dispatch workspace "$HIGHEST_WS"
fi
