#!/bin/sh

if ! pgrep -x hyprsunset ; then
    uwsm app -- hyprsunset -t 5000 &
    notify-send "Hyprsunset on"
else
    kill $(pgrep -x hyprsunset)
    notify-send "Hyprsunset off"
fi

