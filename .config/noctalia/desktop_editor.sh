#!/bin/bash

DESKTOP_DIRS="/usr/share/applications /var/lib/flatpak/exports/share/applications /home/$USER/.local/share/applications" 

DESKTOP_FILE=$(
    find $DESKTOP_DIRS -iname "*.desktop" | 
    noctalia dmenu -p "Select .desktop file to edit:"
)

if [ -n "$DESKTOP_FILE" ]; then
    xdg-open "$DESKTOP_FILE"
fi
