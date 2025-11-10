#!/bin/bash
PIDFILE="/tmp/wl-screenrec.pid"

if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    kill "$(cat "$PIDFILE")"
    rm -f "$PIDFILE"
    notify-send "🎥 Recording stopped"
else
    case "$1" in
	    selection)
		CROP = slurp -w 0
    		wl-screenrec -o "$CROP" -f "$HOME/Videos/Capture/capture-$(date '+%Y%m%d-%H:%M:%S').mp4" --audio & echo $! > "$PIDFILE"
		;;
	    window)
    		wl-screenrec -o "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" -f "$HOME/Videos/Capture/capture-$(date '+%Y%m%d-%H:%M:%S').mp4" --audio & echo $! > "$PIDFILE"
		;;
	    *)
    		wl-screenrec -o "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | "\(.name)"')" -f "$HOME/Videos/Capture/capture-$(date '+%Y%m%d-%H:%M:%S').mp4" --audio & echo $! > "$PIDFILE"
		;;
    esac

    notify-send "🔴 Recording started"
fi
