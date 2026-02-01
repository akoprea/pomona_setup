#!/bin/sh

PLAYERS="vlc spotify" # in priority order

# find the first player that is Playing or Paused
ACTIVE_PLAYER=""
STATUS=""
for PLAYER in $PLAYERS; do
    S=$(playerctl --player="$PLAYER" status 2>/dev/null) || continue
    case "$S" in
        Playing|Paused)
            ACTIVE_PLAYER="$PLAYER"
            STATUS="$S"
            break
            ;;
    esac
done

# handle clicks
case $BLOCK_BUTTON in
    66)  # notify
        if [ -n "$ACTIVE_PLAYER" ]; then
            METADATA=$(playerctl metadata --player="$ACTIVE_PLAYER" --format "{{artist}} - {{album}} - {{title}}")
            notify-send -t 2000 "Now Playing" "$METADATA"
        else
            notify-send -t 2000 "Now Playing" "No track is playing"
        fi
        ## [ -n "$ACTIVE_PLAYER" ] && playerctl --player="$ACTIVE_PLAYER" previous # previous
        ;;
    1)  # play/pause
    	if [ -n "$ACTIVE_PLAYER" ]; then
        	playerctl --player="$ACTIVE_PLAYER" play-pause
        	sleep 0.05 # sleep because this case updates the ICON
        	STATUS=$(playerctl --player="$ACTIVE_PLAYER" status 2>/dev/null) 
    	fi
    	;;
    200)  # previous
    	[ -n "$ACTIVE_PLAYER" ] && playerctl --player="$ACTIVE_PLAYER" previous
        ;;
    3)  # next
        [ -n "$ACTIVE_PLAYER" ] && playerctl --player="$ACTIVE_PLAYER" next
        ;;
    4)  # raise volume
    	[ -n "$ACTIVE_PLAYER" ] && playerctl --player="$ACTIVE_PLAYER" volume "$(playerctl --player="$ACTIVE_PLAYER" volume | awk '{v=$1+0.1; if (v>1) v=1; print v}')" 
    	;;
    5)  # lower volume
    	[ -n "$ACTIVE_PLAYER" ] && playerctl --player="$ACTIVE_PLAYER" volume "$(playerctl --player="$ACTIVE_PLAYER" volume | awk '{v=$1-0.1; if (v>1) v=1; print v}')" 
    	;;
esac

# decide icon
# ▶ ⏸ ❚❚ ⊚ ⊗ 
if [ -n "$ACTIVE_PLAYER" ]; then
    case "$STATUS" in
        Playing) ICON="⊙" ;;
        Paused)  ICON="⊗" ;;
        *)       ICON="❚❚ " ;;
    esac

    # metadata format
    TRUNC_LEN=15
    META="{{ trunc(artist,$TRUNC_LEN) }} - {{ trunc(title,$TRUNC_LEN) }}"

    playerctl metadata --player="$ACTIVE_PLAYER" --format "$ICON$META"
else
    # nothing playing -- show nothing
    echo ""
fi

pkill -RTMIN+4 dwmblocks

exit 0
