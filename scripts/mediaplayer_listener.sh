#!/bin/sh
## %s |
while read -r _; do
	pkill -RTMIN+4 dwmblocks
done < <(playerctl metadata --player=vlc,spotify,firefox --follow) 
# new code to hopefully only show one process

