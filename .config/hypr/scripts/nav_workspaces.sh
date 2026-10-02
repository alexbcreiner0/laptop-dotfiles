#!/bin/bash
direc=$1
# current=$(hyprctl activeworkspace | grep workspace | awk '{print $3}')
current=$(hyprctl activeworkspace -j | jq -r '.id')
if [[ $direc == '--left' ]]; then
    new=$((current-1))
else
    new=$((current+1))
fi

# I think benq is 0 and Sceptre is 1
MONITOR="$(hyprctl activeworkspace | grep monitorID | awk '{print $2}')"
if [[ $MONITOR == '1' && $new -ge 6 && $new -le 10 ]] || [[ $MONITOR == '0' && $new -ge 1 && $new -le 5 ]]; then 
    hyprctl dispatch "hl.dsp.focus({ workspace = \"$new\" })"
fi
