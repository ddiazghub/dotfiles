#!/bin/bash
# Media player script for Waybar using playerctl

player_status=$(playerctl status 2>/dev/null)

if [ -z "$player_status" ] || [ "$player_status" = "No players found" ]; then
    echo '{"text": "", "class": "empty"}'
    exit 0
fi

title=$(playerctl metadata title 2>/dev/null | cut -c1-30)
artist=$(playerctl metadata artist 2>/dev/null | cut -c1-20)
player=$(playerctl metadata --format '{{playerName}}' 2>/dev/null)

# Truncate if too long
if [ ${#title} -eq 30 ]; then
    title="${title}..."
fi

if [ -n "$artist" ]; then
    text="$artist - $title"
else
    text="$title"
fi

# Set icon based on player
player_lower=$(echo "$player" | tr '[:upper:]' '[:lower:]')
case "$player_lower" in
    *spotify*) icon=" ";;
    *firefox*|*zen*) icon=" ";;
    *chrome*|*chromium*|*brave*) icon=" ";;
    *mpv*) icon=" ";;
    *vlc*) icon="󰕼 ";;
    *youtube*|*ytmusic*) icon=" ";;
    *) icon=" ";;
esac

# Set class based on status
case "$player_status" in
    "Playing") class="playing";;
    "Paused")
        icon=" "
        class="paused";;
    *)
        icon=" "
        class="stopped";;
esac

tooltip="$player: $artist - $title"

echo "{\"text\": \" $icon$text \", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
