#!/bin/bash
# Brightness control script with mako progress bar notifications

STEP=5

get_brightness() {
    brightnessctl --class=backlight info | grep -oP '\d+(?=%)'
}

send_notification() {
    local brightness=$(get_brightness)
    local icon

    if [[ $brightness -ge 70 ]]; then
        icon="display-brightness-high"
    elif [[ $brightness -ge 30 ]]; then
        icon="display-brightness-medium"
    else
        icon="display-brightness-low"
    fi

    notify-send \
        --app-name="Brightness" \
        --urgency=low \
        --hint=int:value:$brightness \
        --hint=string:x-canonical-private-synchronous:brightness \
        --icon="$icon" \
        "Brightness" "${brightness}%"
}

case "$1" in
    up)
        brightnessctl --class=backlight set ${STEP}%+
        send_notification
        ;;
    down)
        brightnessctl --class=backlight set ${STEP}%-
        send_notification
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac
