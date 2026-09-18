#!/usr/bin/env bash

set -uo pipefail

CONFIG="$HOME/.config/hypr/waybar/config.jsonc"
STYLE="$HOME/.config/hypr/waybar/style.css"
SHIM="$HOME/.config/hypr/scripts/hypr_ipc_shim.py"

start_plain() {
  # fallback: a bar with dead workspace buttons still beats no bar at all
  exec waybar -c "$CONFIG" -s "$STYLE"
}

[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ] || start_plain

PROXY_HIS="${HYPRLAND_INSTANCE_SIGNATURE}-waybar"
PROXY_DIR="${XDG_RUNTIME_DIR:-/tmp}/hypr/${PROXY_HIS}"

setsid "$SHIM" >"${XDG_RUNTIME_DIR:-/tmp}/hypr-ipc-shim.log" 2>&1 &

for _ in $(seq 1 50); do
  if [ -S "${PROXY_DIR}/.socket.sock" ] && [ -S "${PROXY_DIR}/.socket2.sock" ]; then
    exec env HYPRLAND_INSTANCE_SIGNATURE="$PROXY_HIS" waybar -c "$CONFIG" -s "$STYLE"
  fi
  sleep 0.1
done

echo "waybar_start: shim did not come up, falling back to direct IPC" >&2
start_plain
