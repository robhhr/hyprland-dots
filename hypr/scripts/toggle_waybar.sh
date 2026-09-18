#!/usr/bin/env bash

if pgrep -x waybar >/dev/null; then
  pkill -x waybar
else
  # the wrapper, so that toggling the bar back on keeps the IPC shim that makes
  # workspace clicks work -- see scripts/hypr_ipc_shim.py
  "$HOME/.config/hypr/scripts/waybar_start.sh" &
fi
