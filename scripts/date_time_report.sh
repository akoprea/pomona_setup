#!/bin/sh

# handle clicks
case $BLOCK_BUTTON in
	2)  # launch terminal on middle click
    	setsid alacritty -e sh -c 'cal -y; date "+%X"; echo -e "\nUptime:"; uptime -s; uptime -p; read' >/dev/null 2>&1 &
    	## setsid alacritty >/dev/null 2>&1 &
    	# completely separate terminal from this script
		pkill -RTMIN+1 dwmblocks
		;;
esac

# Output
printf "%s " "$(date '+%a %d %b %I:%M %P')" 
# adds space after
## date "+%a %d %b %I:%M %P"


