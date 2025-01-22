#!/bin/bash
echo "Run Waypaper"
uwsm app -- waypaper
sleep 3
killall -SIGUSR2 waybar
