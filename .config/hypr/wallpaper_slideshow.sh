#!/bin/bash

#~/.local/bin/swww-daemon --quiet &
#sleep 0.2
#~/.local/bin/swww img `find $HOME/Pictures/wall -type f | shuf -n 1`

while true; do
	# Change the wallpaper every 5 minutes
	sleep 5m
	~/.local/bin/swww img `find $HOME/Pictures/wall -type f | shuf -n 1` --transition-type any --transition-fps 120
done

