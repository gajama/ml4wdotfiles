#    ___           __
#   / _ \___  ____/ /__
#  / // / _ \/ __/  '_/
# /____/\___/\__/_/\_\
#
running=$(pgrep -c nwg-dock-hyprla)


config="$HOME/.config/gtk-3.0/settings.ini"
if [ ! -f $HOME/.config/ml4w/settings/dock-disabled ]; then
    prefer_dark_theme="$(grep 'gtk-application-prefer-dark-theme' "$config" | sed 's/.*\s*=\s*//')"
    if [ $prefer_dark_theme == 0 ]; then
        style="style-light.css"
    else
        style="style-dark.css"
    fi
    if [ $running > 1 ] ; then
        killall nwg-dock-hyprland
        $running=0
    fi
    if [ $running = 0 ] ; then
        uwsm app -- nwg-dock-hyprland -r -i 32 -w 5 -mb 10 -ml 10 -mr 10 -s $style -c $HOME/.config/nwg-dock-hyprland/rofi.sh
        #nwg-dock-hyprland -debug -r
    fi
    if [ $running = 1 ] ; then
        pid=$(pgrep nwg-dock-hyprla)
        /usr/bin/kill -s RTMIN+1 $pid
    fi   
fi
