#!/bin/sh

PIDFILE=$HOME/.tmp/hyprsunset

if [ ! -f $PIDFILE ]; then
    uwsm app -- hyprsunset -t 5000 &
    notify-send "Hyprsunset on"
    PID=$(pgrep -x hyprsunset)
    touch $PIDFILE
    echo "$PID" > $PIDFILE
    echo $(cat $PIDFILE)
else
    PID=$(cat $PIDFILE)
    echo $PID
    kill "$PID"
    notify-send "Hyprsunset off"
    rm $PIDFILE
fi

