#!/bin/bash

hyprlock &

sleep 1

pkill -x noctalia
sleep 0.5

systemctl suspend

sleep 1
noctalia -d

