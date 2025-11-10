#!/usr/bin/env bash

PIDFILE="/tmp/wl-screenrec.pid"
STARTFILE="/tmp/wl-screenrec.start"

if [ -f "$PIDFILE" ] && [ -f "$STARTFILE" ]; then
    start_time=$(cat "$STARTFILE")
    elapsed=$(( $(date +%s) - start_time ))
    mins=$(( elapsed / 60 ))
    secs=$(( elapsed % 60 ))
    printf "REC %02d:%02d" "$mins" "$secs"
else
    echo ""
fi

