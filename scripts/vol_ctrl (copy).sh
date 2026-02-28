#!/bin/bash

# handle clicks
case "$BLOCK_BUTTON" in
	1)  # mute toggle
		pactl set-sink-mute @DEFAULT_SINK@ toggle
		;;
    2)  # launch pavucontrols
		setsid sh -c 'pavucontrol' >/dev/null 2>&1 &
		;;
    4)  # volume up
        pactl set-sink-volume @DEFAULT_SINK@ +10%
        ;;
    5)  # volume down
        pactl set-sink-volume @DEFAULT_SINK@ -10%
        ;;
esac

# get volume
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')

# get mute state
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

# output for dwmblocks
if [ "$MUTED" = "yes" ]; then
    echo "⊗$VOLUME" 
else
    echo "⊙$VOLUME"
fi

pkill -RTMIN+3 "${STATUSBAR:-dwmblocks}"

## echo "$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')$MUTESTATE"
