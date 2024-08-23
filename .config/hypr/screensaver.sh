#!/usr/bin/bash

# Choose a screensaver ramdomly
screensaver_chosen=$(($RANDOM % 3))

if [[ "$screensaver_chosen" == "0" ]]; then
	# Sleeping in order to wait for the terminal to be fullscreen, then running pipes
	screensaver="sleep 0.1 && /home/dvt/.local/bin/pipes.sh -r 0 -R -p 5"
elif [[ "$screensaver_chosen" == "1" ]]; then
	screensaver="asciiquarium"
else
	screensaver="cmatrix -s -r"
fi

hyprctl dispatch togglespecialworkspace magic && alacritty -e sh -c "$screensaver" & sleep 0.1 && hyprctl dispatch fullscreen 0

