#!/bin/bash
#  _____                 _       __        __          _
# |_   _|__   __ _  __ _| | ___  \ \      / /_ _ _   _| |__   __ _ _ __
#   | |/ _ \ / _` |/ _` | |/ _ \  \ \ /\ / / _` | | | | '_ \ / _` | '__|
#   | | (_) | (_| | (_| | |  __/   \ V  V / (_| | |_| | |_) | (_| | |
#   |_|\___/ \__, |\__, |_|\___|    \_/\_/ \__,_|\__, |_.__/ \__,_|_|
#            |___/ |___/                         |___/
#
systemctl --user is-active --quiet waybar@-custom.service && systemctl --user stop waybar@-custom.service || systemctl --user restart waybar@-custom.service
systemctl --user is-active --quiet waybar@-custom.service && notify-send "Waybar started" || notify-send "Waybar stopped"
