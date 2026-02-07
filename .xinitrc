## Called by 'startx' to configure xorg server, and start dwm window manager.

# Set fake window manager name so that JDownloader2 works
(sleep 1 && wmname LG3D) &
# must wait until xserver and dwm have fully loaded, thus the sleep.

# Start sxhkd for keyboard shortcuts
exec sxhkd &

# Start dunst for notifications
exec dunst &

# Set cursor size -- I like 2400 CPI (3rd click)
export XCURSOR_SIZE=5
# Tell X server where congfig is
xrdb ~/.Xresources &

# Start status bar and supporting scripts
exec dwmblocks &
(sleep 1 && ~/.#/scripts/mediaplayer_listener.sh) &

# Config monitors
xrandr --output HDMI-A-0 --mode 1920x1080 &
xrandr --output HDMI-A-1-1 --rotate left --mode 1680x1050 --right-of HDMI-A-0 &

# Set wallpapers
feh --bg-fill '/home/zac/.local/share/backgrounds/mono_light_distortion_2.jpg' '/home/zac/.local/share/backgrounds/mono_light_distortion_2.jpg' &
# feh --bg-fill 'file' --bg-fill 'file' &
# wallpapers in ~/.local/share/backgrounds/

# Set starting volume
pactl set-sink-volume 0 50% &
# set to 50%

# Compositing service (no screen tear, fading, shadows)
picom &

# Start DWM
exec dwm

