#!/bin/bash
CONFIG="$HOME/.config/waybar"
hyprctl dispatch exec waybar

while true; do
    inotifywait -e modify -r "$CONFIG"
    pkill waybar
    hyprctl dispatch exec waybar
done
