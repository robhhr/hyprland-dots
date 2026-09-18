#!/bin/bash

items='SUSPEND\nLOG OUT\nRESTART\nPOWER OFF'

height=$(( $(printf '%b\n' "$items" | wc -l) * 30 + 16 ))

choice=$(printf '%b\n' "$items" | wofi --dmenu \
    --hide-search \
    --style ~/.config/wofi/powermenu.css \
    --location top_right \
    --xoffset=-32 --yoffset=12 \
    --width 200 --height "$height")

case "$choice" in
    "POWER OFF")
        systemctl poweroff
        ;;
    RESTART)
        systemctl reboot
        ;;
    SUSPEND)
        systemctl suspend
        ;;
    "LOG OUT")
        hyprctl dispatch exit
        ;;
esac
