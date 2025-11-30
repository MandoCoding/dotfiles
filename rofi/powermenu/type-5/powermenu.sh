#!/usr/bin/env bash

# Current Theme
dir="$HOME/.config/rofi/powermenu/type-5"
theme='style-box'

# Options
shutdown='󰐥'
reboot='󰑓'
lock=''
logout='󰍃'

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -theme "${dir}/${theme}.rasi"
}

# Pass options to rofi
run_rofi() {
    printf '%s\n%s\n%s\n%s\n' "$shutdown" "$reboot" "$logout" "$lock" | rofi_cmd
}

# Execute Command (no confirmation)
run_cmd() {
    case "$1" in
        --shutdown)
            systemctl poweroff
            ;;
        --reboot)
            systemctl reboot
            ;;
        --logout)
            hyprctl dispatch exit 0
            ;;
        --hyprlock)
            hyprlock
            ;;
    esac
}

# Actions
chosen="$(run_rofi)"
case "$chosen" in
    "$shutdown")
        run_cmd --shutdown
        ;;
    "$reboot")
        run_cmd --reboot
        ;;
    "$lock")
        run_cmd --hyprlock
        ;;
    "$logout")
        run_cmd --logout
        ;;
esac

