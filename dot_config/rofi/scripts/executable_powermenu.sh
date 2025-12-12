#!/usr/bin/env bash

# Get selected row from argument, default to 0
selected="${1:-0}"

# Options
shutdown='Shutdown\0icon\x1fsystem-shutdown'
reboot='Reboot\0icon\x1fsystem-reboot'
lock='Lock\0icon\x1fxfce4-system-lock'
suspend='Suspend\0icon\x1fsystem-suspend'
logout='Logout\0icon\x1fxfsm-logout'
yes=' Yes\0icon\x1fdialog-positive'
no=' No\0icon\x1fdialog-error'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-selected-row $selected \
		-config ~/.config/rofi/powermenu.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
		-theme-str 'listbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-mesg "Are you sure?" \
		-no-show-icons \
		-p 'Confirmation' \
		-config ~/.config/rofi/powermenu.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	selected="$(confirm_exit)"
	echo $selected
	if [[ "$selected" == " Yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--suspend' ]]; then
			systemctl suspend
		elif [[ $1 == '--logout' ]]; then
			if [[ "$XDG_CURRENT_DESKTOP" == "niri" ]]; then
				niri msg action quit
			else
				hyprctl dispatch exit
			fi
		fi
	else
		exit 0
	fi
}

# Actions
chosen="$(run_rofi)"
echo $chosen
case ${chosen} in
    'Shutdown') run_cmd --shutdown;;
    'Reboot') run_cmd --reboot;;
    'Lock') hyprlock;;
    'Suspend') run_cmd --suspend;;
    'Logout') run_cmd --logout;;
esac
