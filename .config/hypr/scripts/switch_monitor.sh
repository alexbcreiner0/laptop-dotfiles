#!/bin/bash

WININFO="$(hyprctl activewindow | awk -F': ' '/^[[:space:]]*monitor:/ {print $2; exit}')"
#WININFO="$(hyprctl activewindow | grep monitor | awk '{print $2}')"

echo "$WININFO"

if [[ $WININFO == 1 ]]; then
    echo "Primary monitor"
    WORKSPACE=$(hyprctl monitors | grep -A 7 "(ID 0)" | grep "active workspace" | awk '{print $3}')
    echo "$WORKSPACE"
else
    echo "Secondary monitor"
    WORKSPACE=$(hyprctl monitors | grep -A 7 "(ID 1)" | grep "active workspace" | awk '{print $3}')
    echo "$WORKSPACE"
fi

echo "Captured workspace: '$WORKSPACE'"
# hyprctl dispatch movetoworkspace $WORKSPACE
hyprctl dispatch "hl.dsp.window.move({ workspace = \"$WORKSPACE\" })"

