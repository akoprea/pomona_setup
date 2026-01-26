## Called by 'startx' to configure xorg server, and start dwm window manager.

# Set fake window manager name so that JDownloader2 works
(sleep 1 && wmname LG3D) &
# must wait until xserver and dwm have fully loaded, thus the sleep.

# Start sxhkd for keyboard shortcuts
exec sxhkd &

# Start dunst for notifications
exec dunst &

# Set cursor size -- I like 2400 CPI (3rd click)
## export XCURSOR_SIZE=5
# Tell X server where congfig is
xrdb ~/.Xresources &

# Start status bar and supporting scripts
exec dwmblocks &
(sleep 1 && ~/.#/scripts/mediaplayer_listener.sh) &

# Config first monitor
xrandr --output HDMI-A-0 --mode 1920x1080 &

# Config second monitor
xrandr --output HDMI-A-1-1 --rotate left --mode 1680x1050 --right-of HDMI-A-0 &

# Set wallpaper
feh --bg-scale ~/.local/share/backgrounds/blue_dist_2.jpg --bg-scale ~/.local/share/backgrounds/blue_dist_2.jpg &
# wallpapers in ~/.local/share/backgrounds/
# chroma_dark_2.jpg

# Set starting volume
pactl set-sink-volume 0 50% &
# set to 50%

# Compositing service (no screen tear, fading, shadows)
picom &

# Start DWM
exec dwm

