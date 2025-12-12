#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/.config/rofi/scripts"
ICON_DIR="/usr/share/icons/breeze-dark"

# Define modes with their commands and icons
declare -A modes=(
	["Applications"]="rofi -show drun -config ~/.config/rofi/config.rasi"
	["Run"]="rofi -show run -config ~/.config/rofi/config.rasi"
	["Windows"]="rofi -show window -config ~/.config/rofi/config.rasi"
	["WiFi"]="$SCRIPTS_DIR/wifi.sh"
	["Audio"]="$SCRIPTS_DIR/audio.sh"
	["Wallpaper"]="$SCRIPTS_DIR/wallpaper.sh"
	["Emoji"]="$SCRIPTS_DIR/emoji.sh"
	["Calculator"]="$SCRIPTS_DIR/calc.sh"
	["Clipboard"]="$SCRIPTS_DIR/clipboard.sh"
	["Keyboard"]="$SCRIPTS_DIR/kblayout.sh"
	["Power"]="$SCRIPTS_DIR/powermenu.sh"
)

declare -A icons=(
	["Applications"]="$ICON_DIR/preferences/32/preferences-desktop-launch-feedback.svg"
	["Run"]="$ICON_DIR/actions/22/run-build.svg"
	["Windows"]="$ICON_DIR/actions/22/window.svg"
	["WiFi"]="$ICON_DIR/status/22/network-wireless-100.svg"
	["Audio"]="$ICON_DIR/status/22/audio-volume-high.svg"
	["Wallpaper"]="$ICON_DIR/actions/22/backgroundtool.svg"
	["Emoji"]="$ICON_DIR/emotes/22/face-smile.svg"
	["Calculator"]="$ICON_DIR/apps/48/accessories-calculator.svg"
	["Clipboard"]="$ICON_DIR/actions/22/edit-paste.svg"
	["Keyboard"]="$ICON_DIR/devices/22/input-keyboard.svg"
	["Power"]="$ICON_DIR/actions/22/system-shutdown.svg"
)

# Order of modes
mode_order=(
	"Applications"
	"Run"
	"Windows"
	"WiFi"
	"Audio"
	"Wallpaper"
	"Emoji"
	"Calculator"
	"Clipboard"
	"Keyboard"
	"Power"
)

if [[ "$ROFI_RETV" -eq 0 ]]; then
	# Initial call - return list of options
	echo -en "\0no-custom\x1ftrue\n"
	for mode in "${mode_order[@]}"; do
		echo -en "${mode}\0icon\x1f${icons[$mode]}\n"
	done
elif [[ "$ROFI_RETV" -eq 1 ]]; then
	# User selected an entry
	chosen="$1"
	if [[ -n "${modes[$chosen]}" ]]; then
		coproc (${modes[$chosen]} &>/dev/null)
		exit 0
	fi
fi
