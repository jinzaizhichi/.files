#!/usr/bin/bash

# Choose a screensaver ramdomly
screensaver_chosen=$(($RANDOM % 4))

if [[ "$screensaver_chosen" == "0" ]]; then
	# Sleeping in order to wait for the terminal to be fullscreen, then running pipes
	screensaver="sleep 0.4 && ~/.local/bin/pipes.sh -r 0 -R -p 5"
elif [[ "$screensaver_chosen" == "1" ]]; then
	screensaver="asciiquarium"
elif [[ "$screensaver_chosen" == "2" ]]; then
	screensaver="sleep 0.4 && ~/repo_clones/lavat/lavat -k yellow -c red -s 4 -r 4"
else
	screensaver="cmatrix -r"
fi

hyprctl dispatch togglespecialworkspace magic && alacritty -e sh -c "$screensaver" & sleep 0.3 && hyprctl dispatch fullscreen 0

