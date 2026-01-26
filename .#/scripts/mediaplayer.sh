#!/bin/sh

## FORMAT_FILE="/tmp/dwmblocks_media_format"
## [ ! -f "$FORMAT_FILE" ] && echo "0" > "$FORMAT_FILE"
## FORMAT=$(cat "$FORMAT_FILE")

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
    2)  # play/pause
        [ -n "$ACTIVE_PLAYER" ] && playerctl --player="$ACTIVE_PLAYER" play-pause
        pkill -RTMIN+2 "${STATUSBAR:-dwmblocks}"
        ;;
    3)  # next
        [ -n "$ACTIVE_PLAYER" ] && playerctl --player="$ACTIVE_PLAYER" next
        ;;
    4)  # 4
    	[ -n "$ACTIVE_PLAYER" ] && notify-send -t 1000 "4"
    	;;
    5)  # 5
    	[ -n "$ACTIVE_PLAYER" ] && notify-send -t 1000 "5"
    	;;
esac

# decide icon
if [ -n "$ACTIVE_PLAYER" ]; then
    case "$STATUS" in
        Playing) ICON="▶ " ;;
        Paused)  ICON="⏸ " ;;
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

exit 0
