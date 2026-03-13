#!/usr/bin/env bash
. ~/.cache/wal/colors-rofi.rasi
chosen=$(echo -e "Shutdown\nReboot\nLog Out\nSuspend\nLock" | rofi -dmenu \
    -theme ~/.config/rofi/powermenu.rasi \
    -p "Power Menu" \
    -no-custom \
    -scroll-method 0 \
    -eh 1 \
    -lines 5 \
    -width 7)

case "$chosen" in
    "Shutdown") systemctl poweroff ;;
    "Reboot") systemctl reboot ;;
    "Log Out") hyprctl dispatch exit ;;
    "Suspend") hyprlock & systemctl suspend ;;
    "Lock") hyprlock ;;
esac
