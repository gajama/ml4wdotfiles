#!/bin/bash
killall hypridle
sleep 1
uwsm app -- hypridle &
notify-send "hypridle has been restarted."
