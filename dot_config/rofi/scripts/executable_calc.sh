#!/usr/bin/env bash

rofi -show calc \
	-modi calc \
	-no-show-match \
	-no-sort \
	-calc-command "wl-copy '{result}'" \
	-config ~/.config/rofi/calc.rasi
