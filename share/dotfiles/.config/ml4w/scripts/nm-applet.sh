#!/bin/bash
#                              __    __
#   ___  __ _  ___ ____  ___  / /__ / /_
#  / _ \/  ' \/ _ `/ _ \/ _ \/ / -_) __/
# /_//_/_/_/_/\_,_/ .__/ .__/_/\__/\__/
#                /_/  /_/
#
if [[ "$1" == "stop" ]]; then
    killall nm-applet
    exit
fi

if [[ "$1" == "toggle" ]]; then
    if pgrep -x "nm-applet" > /dev/null
    then
        echo "Running"
        killall nm-applet
        exit
    else
        echo "Stopped"
    fi
fi
uwsm app -- nm-applet --indicator &
