#!/usr/bin/env bash

if pgrep -x waybar >/dev/null; then
  pkill -x waybar
else
  waybar -c "$HOME/.config/hypr/waybar/config.jsonc" \
         -s "$HOME/.config/hypr/waybar/style.css" &
fi
