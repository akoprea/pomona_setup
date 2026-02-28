#!/bin/sh

PLAYERS="spotify firefox vlc"
STATE_FILE="/tmp/dwmblocks_media_player"

# init state
[ ! -f "$STATE_FILE" ] && echo 0 > "$STATE_FILE"
IDX=$(cat "$STATE_FILE")

set -- $PLAYERS
PLAYER_COUNT=$#

# clamp index
[ "$IDX" -ge "$PLAYER_COUNT" ] && IDX=0
[ "$IDX" -lt 0 ] && IDX=0

get_player_by_index() {
    i=0
    for p in $PLAYERS; do
        [ "$i" -eq "$1" ] && echo "$p" && return
        i=$((i + 1))
    done
}

# ───────── handle clicks FIRST ─────────
case $BLOCK_BUTTON in
    2)  # middle click: play / pause
        P=$(get_player_by_index "$IDX")
        [ -n "$P" ] && playerctl --player="$P" play-pause
        ;;
    3)  # right click: next track
        P=$(get_player_by_index "$IDX")
        [ -n "$P" ] && playerctl --player="$P" next
        ;;
    4)  # scroll up: previous player
        IDX=$((IDX - 1))
        [ "$IDX" -lt 0 ] && IDX=$((PLAYER_COUNT - 1))
        echo "$IDX" > "$STATE_FILE"
        ;;
    5)  # scroll down: next player
        IDX=$((IDX + 1))
        [ "$IDX" -ge "$PLAYER_COUNT" ] && IDX=0
        echo "$IDX" > "$STATE_FILE"
        ;;
esac

# ───────── detect active player ─────────
ACTIVE_PLAYER=""
STATUS=""

# prefer selected player
PREF=$(get_player_by_index "$IDX")
if [ -n "$PREF" ]; then
    S=$(playerctl --player="$PREF" status 2>/dev/null)
    case "$S" in
        Playing|Paused)
            ACTIVE_PLAYER="$PREF"
            STATUS="$S"
        ;;
    esac
fi

# fallback to first active player
if [ -z "$ACTIVE_PLAYER" ]; then
    i=0
    for p in $PLAYERS; do
        S=$(playerctl --player="$p" status 2>/dev/null) || {
            i=$((i + 1))
            continue
        }
        case "$S" in
            Playing|Paused)
                ACTIVE_PLAYER="$p"
                STATUS="$S"
                IDX="$i"
                echo "$IDX" > "$STATE_FILE"
                break
                ;;
        esac
        i=$((i + 1))
    done
fi

# ───────── output block ─────────
if [ -n "$ACTIVE_PLAYER" ]; then
    case "$STATUS" in
        Playing) ICON="▶ " ;;
        Paused)  ICON="⏸ " ;;
        *)       ICON="❚❚ " ;;
    esac

    TRUNC_LEN=15
    META="{{ trunc(artist,$TRUNC_LEN) }} - {{ trunc(title,$TRUNC_LEN) }}"

    playerctl --player="$ACTIVE_PLAYER" metadata \
        --format "$ICON$META"
else
    echo ""
fi

exit 0


