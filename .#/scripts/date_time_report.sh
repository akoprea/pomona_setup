#!/bin/sh

# handle clicks
case $BLOCK_BUTTON in
	2)  # launch terminal on middle click
    	setsid alacritty -e sh -c 'cal -y; read' >/dev/null 2>&1 &
    	## setsid alacritty >/dev/null 2>&1 &
    	# completely separate terminal from this script
		pkill -RTMIN+1 dwmblocks
		;;
esac

# Output
date "+%a %d %b %I:%M %P"


