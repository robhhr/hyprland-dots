#!/bin/bash
# wifi menu: same wofi look as powermenu.sh
# normal window (not layer) so the click handler in lua/binds.lua can close it; placement
# comes from the "wifi-menu" window rule in lua/config.lua

# clicking the bar icon while open = close it ("--prompt wifi" tags our wofis)
pkill -f 'wofi .*--prompt wifi' && exit 0

common=(--dmenu --normal-window --width 320)

menu() { # $1 = newline-separated items
    local height=$(( $(printf '%s\n' "$1" | wc -l) * 30 + 16 ))
    printf '%s\n' "$1" | wofi "${common[@]}" --prompt wifi \
        --hide-search -D single_click=true \
        --style ~/.config/wofi/powermenu.css \
        --height "$(( height > 436 ? 436 : height ))"
}

if [[ $(nmcli radio wifi) != enabled ]]; then
    [[ $(menu 'TURN WIFI ON') ]] && nmcli radio wifi on && notify-send "wifi" "turned on"
    exit 0
fi

# ssid -> saved profile names (a ssid can have several, e.g. "@yvrairport 1")
declare -A saved
while IFS=: read -r name type; do
    [[ $type == 802-11-wireless ]] || continue
    ssid=$(nmcli -g 802-11-wireless.ssid connection show id "$name")
    saved[$ssid]+="$name"$'\n'
done < <(nmcli -t -f NAME,TYPE connection show)

icons=(󰤯 󰤟 󰤢 󰤥 󰤨)
declare -A line2ssid secure seen
items='TURN WIFI OFF'
# ssid last so colons inside it survive the split
while IFS=: read -r inuse signal security ssid; do
    [[ -z $ssid || ${seen[$ssid]} ]] && continue
    seen[$ssid]=1
    tag=''
    [[ ${saved[$ssid]} ]] && tag='  (saved)'
    [[ $inuse == '*' ]] && tag='  (connected)'
    line="${icons[signal / 21]}  $ssid$tag"
    line2ssid[$line]=$ssid
    secure[$ssid]=$security
    items+=$'\n'"$line"
# cached list = instant menu; in-use row first so dedupe keeps "(connected)"
done < <(nmcli -t --escape no -f IN-USE,SIGNAL,SECURITY,SSID device wifi list --rescan no | LC_ALL=C sort -s -r -t: -k1,1)
nmcli device wifi rescan &>/dev/null & # fresh results for next open

choice=$(menu "$items")
[[ $choice ]] || exit 0 # closed (esc, click outside, icon) can still exit 0
[[ $choice == 'TURN WIFI OFF' ]] && { nmcli radio wifi off && notify-send "wifi" "turned off"; exit 0; }
ssid=${line2ssid[$choice]}
[[ $ssid ]] || exit 0

if [[ $choice == *'(connected)' ]]; then
    action=$(menu $'DISCONNECT\nFORGET')
elif [[ ${saved[$ssid]} ]]; then
    action=$(menu $'CONNECT\nFORGET')
else
    action=CONNECT # new network: nothing to forget, skip the extra menu
fi

case "$action" in
    DISCONNECT)
        dev=$(nmcli -t -f DEVICE,TYPE device | awk -F: '$2=="wifi"{print $1; exit}')
        nmcli device disconnect "$dev" >/dev/null && notify-send "wifi" "disconnected from $ssid"
        ;;
    FORGET)
        while read -r name; do
            [[ $name ]] && nmcli connection delete id "$name" >/dev/null
        done <<< "${saved[$ssid]}"
        notify-send "wifi" "forgot $ssid"
        ;;
    CONNECT)
        if [[ ${saved[$ssid]} ]]; then
            out=$(nmcli connection up id "$(head -n1 <<< "${saved[$ssid]}")" 2>&1)
        elif [[ ${secure[$ssid]} ]]; then
            # plain entry = no search icon. the hint row keeps focus off the
            # entry so the prompt stays visible; exec_search makes enter
            # return the typed text, or the hint itself when nothing was typed
            hint='󰌾  enter to connect'
            pass=$(printf '%s\n' "$hint" | wofi "${common[@]}" --prompt "wifi password for $ssid" \
                --password -D use_search_box=false -D exec_search=true \
                --style ~/.config/wofi/style.css -L 1)
            [[ $pass && $pass != "$hint" ]] || exit 0
            out=$(nmcli device wifi connect "$ssid" password "$pass" 2>&1) \
                || { nmcli connection delete id "$ssid" &>/dev/null; false; } # drop the half-made profile
        else
            out=$(nmcli device wifi connect "$ssid" 2>&1)
        fi
        if [[ $? -eq 0 ]]; then
            notify-send "wifi" "connected to $ssid"
        else
            notify-send "wifi" "failed: $out"
        fi
        ;;
esac
