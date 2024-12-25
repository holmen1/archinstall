#!/bin/bash

WAYBAR_PID=$(pgrep waybar)

if [ -z "$WAYBAR_PID" ]; then
    nohup waybar > /dev/null 2>&1 &
else
    pkill waybar
    while pgrep waybar >/dev/null; do sleep 0.1; done
fi