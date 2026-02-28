#!/bin/bash

#### Debug dummy script. 
# does whatever is needed

# handle clicks
case $BLOCK_BUTTON in
    1)  # left
    	## notify-send -t 1000 "left"
    	rofi -show drun -display-drun "Select a program to run" -terminal alacritty
    	;;
    2)  # middle
        notify-send -t 1000 "middle"
        ;;
    3)  # right
        notify-send -t 1000 "right"
        ;;
esac

echo " " # output so something shows up
pkill -RTMIN+5 dwmblocks

