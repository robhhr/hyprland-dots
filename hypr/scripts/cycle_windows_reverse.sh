#!/bin/bash

clients=$(hyprctl clients -j | jq -c 'sort_by(.last_focus_time) | reverse | .[]')
current=$(hyprctl activewindow -j | jq -r '.address')

addr_array=()

while IFS= read -r client; do
    ws_name=$(echo "$client" | jq -r '.workspace.name')
    addr=$(echo "$client" | jq -r '.address')

    # fallback if workspace.name is null
    if [[ "$ws_name" == "null" ]]; then
        ws_name=""
    fi

    # skip if on hidden workspace
    if [[ "$ws_name" != "order66" ]]; then
        addr_array+=("$addr")
    fi
done <<< "$clients"

# if no valid windows
if [ ${#addr_array[@]} -eq 0 ]; then
    exit 0
fi

# find current window index
for i in "${!addr_array[@]}"; do
    if [[ "${addr_array[$i]}" == "$current" ]]; then
        prev_index=$(( (i - 1 + ${#addr_array[@]}) % ${#addr_array[@]} ))
        hyprctl dispatch "hl.dsp.focus({ window = 'address:${addr_array[$prev_index]}' })"
        break
    fi
done

