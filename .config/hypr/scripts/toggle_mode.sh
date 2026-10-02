#!/bin/bash

check=$(grep "layout" ~/dotfiles/.config/hypr/general.lua | awk '{print $3}')

if [ $check == "\"dwindle\"," ]; then
    sed -i 's/\"dwindle\",/\"master\",/' ~/dotfiles/.config/hypr/general.lua
    exit 0
elif [ $check == "\"master\"," ]; then
    sed -i 's/\"master\",/\"dwindle\",/' ~/dotfiles/.config/hypr/general.lua
    exit 0
else
    echo "Don't recognize current setting, $check"
    exit 1
fi
