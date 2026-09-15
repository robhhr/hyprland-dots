#!/bin/bash

choice=$(printf "SUSPEND\nLOG OUT\nRESTART\nPOWER OFF\n" | wofi --dmenu \
    --hide-search \
    --style ~/.config/wofi/powermenu.css \
    --location top_right \
    --xoffset=-24 --yoffset=12 \
    --width 200 --height 140)

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
