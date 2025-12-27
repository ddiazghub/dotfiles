#!/bin/bash
# Pacman updates check script for Waybar
# Always outputs immediately, runs check in background if needed

LOCK_FILE="/tmp/checkupdates.lock"
CACHE_FILE="/tmp/waybar-pacman-count"

# If no cache exists, create initial placeholder
if [ ! -f "$CACHE_FILE" ]; then
    echo '{"text": "...", "tooltip": "Checking for updates...", "class": "checking"}' > "$CACHE_FILE"
fi

# Always output current cache immediately
cat "$CACHE_FILE"

# Run the actual check in background (for next refresh)
(
    flock -n 9 || exit 0

    count=$(checkupdates 2>/dev/null | wc -l)

    if [ "$count" -gt 0 ]; then
        tooltip=$(checkupdates 2>/dev/null | head -10 | sed 's/"/\\"/g' | tr '\n' '\\' | sed 's/\\/\\n/g' | sed 's/\\n$//')
        echo "{\"text\": \"$count\", \"tooltip\": \"$tooltip\", \"class\": \"updates\"}" > "$CACHE_FILE"
    else
        echo '{"text": "0", "tooltip": "System is up to date", "class": "none"}' > "$CACHE_FILE"
    fi
) 9>"$LOCK_FILE" &

disown
