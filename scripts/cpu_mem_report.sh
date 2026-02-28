#!/bin/sh

# handle clicks
case $BLOCK_BUTTON in
    2)  # launch htop
        ## notify-send "Launching htop"
        setsid alacritty -e sh -c 'htop' >/dev/null 2>&1 &
        ## alacritty -e htop &
        pkill -RTMIN+2 dwmblocks
        ;;
esac

# CPU load (1-minute average)
cpu=$(cut -d' ' -f1 /proc/loadavg)

# Memory used (used / total)
mem=$(free -h | awk '/^Mem:/ {print $3}')  # for total add:: "/" $2

# Output
printf "$cpu $mem"

