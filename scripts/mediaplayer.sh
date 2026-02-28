#!/bin/sh

# Pairs with mediaplayer_listener.sh which should be ran at start of xserver. This script will be called by dwmblocks-async. 

PLAYERS=$(<~/.#/scripts/players.txt) # read players from file.
## PLAYERS="vlc spotify"
## priority: vlc,spotify,firefox

# find the first player that is Playing or Paused
## call mediaplayer_listener.sh here??
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
    1)  # play/pause
    	if [ -n "$ACTIVE_PLAYER" ]; then
        	playerctl --player="$ACTIVE_PLAYER" play-pause
        	sleep 0.05 # sleep because this case updates the ICON
        	STATUS=$(playerctl --player="$ACTIVE_PLAYER" status 2>/dev/null) 
    	fi
    	;;
    2)  # notify
        if [ -n "$ACTIVE_PLAYER" ]; then
            METADATA=$(playerctl metadata --player="$ACTIVE_PLAYER" --format "ARTIST: {{artist}}\nALBUM: {{album}}\nSONG: {{title}}")
            notify-send -t 3000 "Now Playing" "$METADATA"
            ## printf "$(date):\n$METADATA\n\n" >> song_hist.txt 
            ## save song to file in ~
        else
            notify-send -t 3000 "Now Playing" "No track is playing"
        fi
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

OUTSTRING="" # empty output string. defacto 'else'
# decide icon and format output
# ▶ ⏸ ❚❚ ⊗ ⊙
if [ -n "$ACTIVE_PLAYER" ]; then
    case "$STATUS" in
        Playing) ICON="⊙" ;;
        Paused)  ICON="⊗" ;;
        *)       ICON="❚❚ " ;;
    esac
    # metadata format
    TRUNCLEN=15
    META="{{ trunc(artist,$TRUNCLEN) }} - {{ trunc(title,$TRUNCLEN) }}"
	
	OUTSTRING="$(playerctl metadata --player="$ACTIVE_PLAYER" --format "$ICON$META")"
fi

# Output and signal dwmblocks
printf "%s" "$OUTSTRING"
pkill -RTMIN+4 dwmblocks

exit 0
