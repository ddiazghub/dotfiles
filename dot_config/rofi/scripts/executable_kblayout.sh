#!/usr/bin/env bash

FLAGS_DIR="$HOME/.local/share/icons/flags"

# Get current layout index and calculate next
layouts=$(niri msg -j keyboard-layouts)
current_idx=$(echo "$layouts" | jq '.current_idx')
total=$(echo "$layouts" | jq '.names | length')
next_idx=$(( (current_idx + 1) % total ))

pkill rofi &

# Switch layout immediately
niri msg action switch-layout "$next_idx"

# Options with icons
us="English (US)\0icon\x1f${FLAGS_DIR}/us.svg"
latam="Spanish (LATAM)\0icon\x1f${FLAGS_DIR}/co.svg"

# Show rofi with new layout highlighted (visual feedback)
# Alt+Space cycles to next, Enter confirms current
chosen=$(echo -e "$us\n$latam" | rofi -dmenu -p "Keyboard" -selected-row "$next_idx" \
	-no-custom \
	-kb-move-char-forward '' -kb-move-char-back '' \
	-config ~/.config/rofi/kblayout.rasi)
exit_code=$?

# Handle selection
if [[ $exit_code -eq 10 ]]; then
	# Alt+Space pressed - cycle to next (script will be re-triggered by niri)
	exit 0
elif [[ -n "$chosen" ]]; then
	case ${chosen} in
		'English (US)') niri msg action switch-layout 0 ;;
		'Spanish (LATAM)') niri msg action switch-layout 1 ;;
	esac
fi
