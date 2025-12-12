#!/usr/bin/env bash

# Icons
SPEAKER_ICON="audio-speakers"
MIC_ICON="audio-input-microphone"
MUTE_ICON="audio-volume-muted"
UNMUTE_ICON="audio-volume-high"

# Check mute status
is_muted() {
	wpctl get-volume "@DEFAULT_${1^^}@" 2>/dev/null | rg -q '\[MUTED\]'
}

# List all devices (both sinks and sources)
list_devices() {
	# Output devices header
	echo -e "── Output ──\0icon\x1f${SPEAKER_ICON}\x1fnonselectable\x1ftrue"

	# Parse wpctl status for sinks (output)
	wpctl status | sed -n "/Audio/,/Video/p" | sed -n "/Sinks:/,/Sources:/p" | head -n -1 | tail -n +2 | while read -r line; do
		[[ -z "$line" || "$line" =~ ^[[:space:]]*$ ]] && continue

		if [[ "$line" =~ ^[[:space:]│]*\*?[[:space:]]*([0-9]+)\.[[:space:]]+(.+)[[:space:]]+\[vol ]]; then
			id="${BASH_REMATCH[1]}"
			name="${BASH_REMATCH[2]}"
			name=$(echo "$name" | sed 's/[[:space:]]*$//')

			if [[ "$line" =~ ^.*\*[[:space:]]*[0-9] ]]; then
				suffix=" ✔️"
			else
				suffix="   "
			fi

			echo -e "${name}${suffix}\0icon\x1f${SPEAKER_ICON}\x1fmeta\x1fsink:${id}"
		fi
	done

	# Input devices header
	echo -e "── Input ──\0icon\x1f${MIC_ICON}\x1fnonselectable\x1ftrue"

	# Parse wpctl status for sources (input)
	wpctl status | sed -n "/Audio/,/Video/p" | sed -n "/Sources:/,/Filters:/p" | head -n -1 | tail -n +2 | while read -r line; do
		[[ -z "$line" || "$line" =~ ^[[:space:]]*$ ]] && continue

		if [[ "$line" =~ ^[[:space:]│]*\*?[[:space:]]*([0-9]+)\.[[:space:]]+(.+)[[:space:]]+\[vol ]]; then
			id="${BASH_REMATCH[1]}"
			name="${BASH_REMATCH[2]}"
			name=$(echo "$name" | sed 's/[[:space:]]*$//')

			if [[ "$line" =~ ^.*\*[[:space:]]*[0-9] ]]; then
				suffix=" ✔️"
			else
				suffix="   "
			fi

			echo -e "${name}${suffix}\0icon\x1f${MIC_ICON}\x1fmeta\x1fsource:${id}"
		fi
	done

	# Mute toggles header
	echo -e "── Controls ──\0icon\x1f${MUTE_ICON}\x1fnonselectable\x1ftrue"

	# Mute toggles
	if is_muted "sink"; then
		echo -e "Unmute Output\0icon\x1f${UNMUTE_ICON}"
	else
		echo -e "Mute Output\0icon\x1f${MUTE_ICON}"
	fi

	if is_muted "source"; then
		echo -e "Unmute Input\0icon\x1f${UNMUTE_ICON}"
	else
		echo -e "Mute Input\0icon\x1f${MUTE_ICON}"
	fi
}

# Set default device
set_default() {
	local id="$1"
	local type="$2"
	wpctl set-default "$id"

	# Get device name for notification
	local name=$(wpctl inspect "$id" 2>/dev/null | rg 'node.description' | sed 's/.*= "//' | sed 's/"$//')
	[[ -z "$name" ]] && name="Device $id"

	if [[ "$type" == "sink" ]]; then
		notify-send "Audio Output" "Switched to $name"
	else
		notify-send "Audio Input" "Switched to $name"
	fi
}

# Rofi command
rofi_cmd() {
	rofi -dmenu \
		-p "Audio" \
		-config ~/.config/rofi/audio.rasi
}

# Run
chosen=$(list_devices | rofi_cmd)

if [[ -n "$chosen" && "$chosen" != ──* ]]; then
	case "$chosen" in
		"Mute Output")
			wpctl set-mute @DEFAULT_SINK@ 1
			notify-send "Audio" "Output muted"
			;;
		"Unmute Output")
			wpctl set-mute @DEFAULT_SINK@ 0
			notify-send "Audio" "Output unmuted"
			;;
		"Mute Input")
			wpctl set-mute @DEFAULT_SOURCE@ 1
			notify-send "Audio" "Input muted"
			;;
		"Unmute Input")
			wpctl set-mute @DEFAULT_SOURCE@ 0
			notify-send "Audio" "Input unmuted"
			;;
		*)
			# Remove suffix
			name=$(echo "$chosen" | sed 's/ *✔️$//' | sed 's/ *$//')

			# Find the device ID and type by matching name in wpctl output
			wpctl_output=$(wpctl status)

			# Check if it's a sink or source
			if echo "$wpctl_output" | sed -n "/Sinks:/,/Sources:/p" | rg -q "$name"; then
				type="sink"
			else
				type="source"
			fi

			# Find the device ID
			id=$(echo "$wpctl_output" | rg -o "([0-9]+)\.\s+${name}" -r '$1' | head -1)

			if [[ -n "$id" ]]; then
				set_default "$id" "$type"
			fi
			;;
	esac
fi
