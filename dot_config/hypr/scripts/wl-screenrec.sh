#!/bin/bash
PIDFILE="/tmp/wl-screenrec.pid"
LOCKFILE="/tmp/wl-screenrec.lock"

if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    kill "$(cat "$PIDFILE")"
    rm -f "$PIDFILE"
    notify-send "🎥 Recording stopped"
    exit 0
fi

# Prevent triggering during selection
if [ -f "$LOCKFILE" ]; then
    exit 0
fi

touch "$LOCKFILE"

# Recording filename
FILENAME="$HOME/Videos/Capture/capture-$(date '+%Y%m%d-%H:%M:%S').mp4"

case "$1" in
    selection)
        REGION=$(slurp -w 0)
        if [ -z "$REGION" ]; then
            rm -f "$LOCKFILE"
            exit 1
        fi

        wl-screenrec -g "$REGION" -f "$FILENAME" --audio &
        ;;

    window)
        REGION=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        wl-screenrec -g "$REGION" -f "$FILENAME" --audio &
    ;;
    *)
        MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | "\(.name)"')
        wl-screenrec -o "$MONITOR" -f "$FILENAME" --audio &
    ;;
esac

echo $! > "$PIDFILE"
rm -f "$LOCKFILE"

notify-send "🔴 Recording started"
