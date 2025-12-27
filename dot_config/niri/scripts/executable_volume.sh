#!/bin/bash
# Volume control script with mako progress bar notifications

SINK="@DEFAULT_AUDIO_SINK@"
STEP=5

get_volume() {
    wpctl get-volume $SINK | awk '{print int($2 * 100)}'
}

is_muted() {
    wpctl get-volume $SINK | grep -q MUTED
}

send_notification() {
    local volume=$(get_volume)
    local icon

    if is_muted; then
        icon="audio-volume-muted"
        volume=0
    elif [[ $volume -ge 70 ]]; then
        icon="audio-volume-high"
    elif [[ $volume -ge 30 ]]; then
        icon="audio-volume-medium"
    else
        icon="audio-volume-low"
    fi

    notify-send \
        --app-name="Volume" \
        --hint=int:value:$volume \
        --hint=string:x-canonical-private-synchronous:volume \
        --icon="$icon" \
        "Volume" "${volume}%"
}

case "$1" in
    up)
        wpctl set-volume -l 1 $SINK ${STEP}%+
        send_notification
        ;;
    down)
        wpctl set-volume $SINK ${STEP}%-
        send_notification
        ;;
    mute)
        wpctl set-mute $SINK toggle
        send_notification
        ;;
    mic-mute)
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED; then
            notify-send \
                --app-name="Microphone" \
                --hint=string:x-canonical-private-synchronous:mic \
                --icon="microphone-sensitivity-muted" \
                "Microphone" "Muted"
        else
            notify-send \
                --app-name="Microphone" \
                --hint=string:x-canonical-private-synchronous:mic \
                --icon="microphone-sensitivity-high" \
                "Microphone" "Unmuted"
        fi
        ;;
    *)
        echo "Usage: $0 {up|down|mute|mic-mute}"
        exit 1
        ;;
esac
