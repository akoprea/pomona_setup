#!/bin/sh
playerctl metadata --player=vlc,spotify --follow |
while read -r _; do
	pkill -RTMIN+4 dwmblocks
done

