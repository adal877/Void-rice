#!/bin/sh

PID=$(ps -fu $USER | grep "dual" | grep -v "grep" | awk '{print $2}')
kill $PID
polybar -c ~/.config/polybar/config.m2 dual &
