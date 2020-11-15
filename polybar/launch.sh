#!/bin/sh

killall -q polybar

polybar -c ~/.config/polybar/config example &
