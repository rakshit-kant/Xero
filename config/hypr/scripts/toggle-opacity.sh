#!/usr/bin/env bash

CURRENT=$(hyprctl activewindow -j | jq '.opacity')

if [[ "$CURRENT" == "1.0" ]]; then
    hyprctl dispatch setprop active opacity 0.85
else
    hyprctl dispatch setprop active opacity 1.0
fi
