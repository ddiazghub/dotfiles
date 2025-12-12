#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/.config/rofi/scripts"

# Menu options
declare -A modes=(
	["󰀻 Applications"]="rofi -show drun -config ~/.config/rofi/config.rasi"
	[" Run"]="rofi -show run -config ~/.config/rofi/config.rasi"
	[" Windows"]="rofi -show window -config ~/.config/rofi/config.rasi"
	["󰖟 WiFi"]="$SCRIPTS_DIR/wifi.sh"
	["󰕾 Audio"]="$SCRIPTS_DIR/audio.sh"
	["󰸉 Wallpaper"]="$SCRIPTS_DIR/wallpaper.sh"
	["󰞅 Emoji"]="$SCRIPTS_DIR/emoji.sh"
	["󰃬 Calculator"]="$SCRIPTS_DIR/calc.sh"
	["󰗊 Clipboard"]="$SCRIPTS_DIR/clipboard.sh"
	["󰌌 Keyboard"]="$SCRIPTS_DIR/kblayout.sh"
	["󰐥 Power"]="$SCRIPTS_DIR/powermenu.sh"
)

# Build menu
list_modes() {
	for mode in "󰀻 Applications" " Run" " Windows" "󰖟 WiFi" "󰕾 Audio" "󰸉 Wallpaper" "󰞅 Emoji" "󰃬 Calculator" "󰗊 Clipboard" "󰌌 Keyboard" "󰐥 Power"; do
		echo "$mode"
	done
}

# Rofi command
rofi_cmd() {
	rofi -dmenu \
		-p "Mode" \
		-config ~/.config/rofi/launcher.rasi
}

# Run
chosen=$(list_modes | rofi_cmd)

if [[ -n "$chosen" && -n "${modes[$chosen]}" ]]; then
	exec ${modes[$chosen]}
fi
