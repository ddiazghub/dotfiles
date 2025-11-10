#!/bin/bash
CONFIG_FILE="$HOME/.config/hypr/hypridle.conf"
hyprctl dispatch exec hypridle

while true; do
    inotifywait -e modify "$CONFIG_FILE"
    pkill hypridle
    hyprctl dispatch exec hypridle
done
