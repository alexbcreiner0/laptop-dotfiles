#!/bin/bash
direc=$1
# current=$(hyprctl activeworkspace | grep workspace | awk '{print $3}')
current=$(hyprctl activeworkspace -j | jq -r '.id')
if [[ $direc == '--left' ]]; then
    new=$((current-1))
else
    new=$((current+1))
fi

# Desktop
# # I think BenQ is 0 and DP-3 is 1
MONITOR="$(hyprctl activeworkspace | grep monitorID | awk '{print $2}')"
echo $MONITOR
if [[ $MONITOR == '1' && $new -ge 6 && $new -le 10 ]] || [[ $MONITOR == '0' && $new -ge 1 && $new -le 5 ]]; then 
    hyprctl dispatch "hl.dsp.window.move({ workspace = \"$new\" })"
    # hyprctl dispatch movetoworkspace $new
fi
