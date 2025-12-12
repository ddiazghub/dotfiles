#!/usr/bin/env bash

# Icons (using standard freedesktop names)
WIFI_ICON="network-wireless-signal-excellent"
WIFI_CONNECTED_ICON="network-wireless-signal-excellent"
WIFI_LOCK_ICON="network-wireless-signal-excellent"
WIFI_DISCONNECTED_ICON="network-offline"
REFRESH_ICON="view-refresh"

# Max SSID display length (to prevent overlap)
MAX_SSID_LEN=30

# Get current connection
get_current_ssid() {
	nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d':' -f2
}

# Toggle WiFi on/off
toggle_wifi() {
	status=$(nmcli radio wifi)
	if [[ "$status" == "enabled" ]]; then
		nmcli radio wifi off
	else
		nmcli radio wifi on
	fi
}

# Scan and list networks
list_networks() {
	current_ssid=$(get_current_ssid)

	# Get saved connections (known networks)
	saved_networks=$(nmcli -t -f NAME con show)

	# Rescan networks (async, don't wait)
	nmcli dev wifi rescan 2>/dev/null &

	# Get list of networks
	nmcli -t -f SSID,SECURITY,SIGNAL,IN-USE dev wifi list | while IFS=':' read -r ssid security signal in_use; do
		# Skip empty SSIDs
		[[ -z "$ssid" ]] && continue

		# Truncate SSID if too long
		if [[ ${#ssid} -gt $MAX_SSID_LEN ]]; then
			display_ssid="${ssid:0:$((MAX_SSID_LEN-3))}..."
		else
			display_ssid="$ssid"
		fi

		# Determine icon and suffix based on security and connection status
		icon="$WIFI_ICON"
		suffix=""

		# Check if this is a saved/known network
		is_saved=$(echo "$saved_networks" | rg -Fx "$ssid")

		# Add lock only for secured networks that are NOT saved
		if [[ "$security" != "" && "$security" != "--" && -z "$is_saved" ]]; then
			suffix=" 🔒"
		elif [[ "$in_use" == "*" ]]; then
			suffix=" ✔️"
		else
			suffix="   "
		fi

		# Signal indicator
		if [[ $signal -ge 75 ]]; then
			signal_str="▂▄▆█"
		elif [[ $signal -ge 50 ]]; then
			signal_str="▂▄▆_"
		elif [[ $signal -ge 25 ]]; then
			signal_str="▂▄__"
		else
			signal_str="▂___"
		fi

		# Pad SSID to align signal indicators
		printf -v padded_ssid "%-${MAX_SSID_LEN}s" "$display_ssid"
		echo -e "${padded_ssid}${suffix} ${signal_str}\0icon\x1f${icon}"
	done

	# Add refresh option
	echo -e "Refresh Networks\0icon\x1f${REFRESH_ICON}"

	# Add toggle option
	wifi_status=$(nmcli radio wifi)
	if [[ "$wifi_status" == "enabled" ]]; then
		echo -e "Disable WiFi\0icon\x1f${WIFI_DISCONNECTED_ICON}"
	else
		echo -e "Enable WiFi \0icon\x1f${WIFI_ICON}"
	fi
}

# Connect to a network
connect_network() {
	ssid="$1"

	# Check if we have a saved connection
	if nmcli -t -f NAME con show | grep -qx "$ssid"; then
		nmcli con up "$ssid" && notify-send "WiFi" "Connected to $ssid" || notify-send "WiFi" "Failed to connect to $ssid"
	else
		# Ask for password
		password=$(rofi -dmenu -p "Password" -password \
			-config ~/.config/rofi/wifi.rasi)

		if [[ -n "$password" ]]; then
			nmcli dev wifi connect "$ssid" password "$password" && \
				notify-send "WiFi" "Connected to $ssid" || \
				notify-send "WiFi" "Failed to connect to $ssid"
		fi
	fi
}

# Main rofi command
rofi_cmd() {
	rofi -dmenu \
		-p "WiFi" \
		-config ~/.config/rofi/wifi.rasi
}

# Check if WiFi is enabled
wifi_status=$(nmcli radio wifi)
if [[ "$wifi_status" == "disabled" ]]; then
	chosen=$(echo -e "Enable WiFi\0icon\x1f${WIFI_ICON}" | rofi_cmd)
	if [[ "$chosen" == "Enable WiFi" ]]; then
		nmcli radio wifi on
		sleep 2
		exec "$0"
	fi
	exit 0
fi

# Run main menu
chosen=$(list_networks | rofi_cmd)

echo $chosen
# Handle selection
case "$chosen" in
	"Refresh Networks")
		nmcli dev wifi rescan
		sleep 1
		exec "$0"
		;;
	"Disable WiFi")
		nmcli radio wifi off
		notify-send "WiFi" "WiFi disabled"
		;;
	"Enable WiFi")
		nmcli radio wifi on
		notify-send "WiFi" "WiFi enabled"
		sleep 2
		exec "$0"
		;;
	*)
		if [[ -n "$chosen" ]]; then
			# Extract SSID (remove padding, suffix, and signal indicator)
			ssid=$(echo "$chosen" | sed 's/ *\*\? *🔒\? *▂.*$//' | sed 's/ *$//')

			# Check if already connected
			current=$(get_current_ssid)
			if [[ "$ssid" == "$current" ]]; then
				# Offer to disconnect
				action=$(echo -e "Disconnect\0icon\x1f${WIFI_DISCONNECTED_ICON}\nCancel\0icon\x1fdialog-cancel" | \
					rofi -dmenu -p "$ssid" \
					-theme-str 'window {width: 250px;}' \
					-theme-str 'listview {lines: 2;}' \
					-theme-str 'entry {placeholder: "Enter Password";}' \
					-config ~/.config/rofi/wifi.rasi)

				if [[ "$action" == "Disconnect" ]]; then
					nmcli con down "$ssid"
					notify-send "WiFi" "Disconnected from $ssid"
				fi
			else
				connect_network "$ssid"
			fi
		fi
		;;
esac
