#!/bin/bash

ACTION=$(echo -e "Shutdown\nSuspend\nReboot\nCancel Scheduled" | rofi -dmenu -p "Schedule Action" \
    -theme-str 'inputbar { enabled: false; }' \
    -theme-str 'mainbox { children: [ listview ]; }' \
    -theme-str 'element-text { horizontal-align: 0.5; }' \
    -theme-str 'listview { lines: 4; scrollbar: false; }' \
    -theme-str 'window { width: 300px; height: 220px; }' \
    -no-custom)

[ -z "$ACTION" ] && exit 0

if [ "$ACTION" = "Cancel Scheduled" ]; then
    JOBS=$(atq | awk '{print $1}')
    if [ -z "$JOBS" ]; then
        notify-send "Schedule" "No scheduled actions"
    else
        echo "$JOBS" | xargs atrm
        notify-send "Schedule" "All scheduled actions cancelled"
    fi
    exit 0
fi

TIME=$(rofi -dmenu -p "" \
    -theme-str 'listview { enabled: false; }' \
    -theme-str 'mainbox { children: [ inputbar ]; }' \
    -theme-str 'entry { placeholder: "Perform action at (HH:MM):"; }' \
    -theme-str 'window { width: 300px; height: 60px; }')

[ -z "$TIME" ] && exit 0

DBUS="DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus"

case "$ACTION" in
    "Shutdown")
        echo "$DBUS notify-send -u critical 'Scheduled Shutdown' 'System will shutdown in 2 minutes'" | at "$TIME" - 2 minutes
        echo "$DBUS notify-send -u critical 'Scheduled Shutdown' 'System will shutdown in 1 minute'" | at "$TIME" - 1 minute
        echo "sudo systemctl poweroff" | at "$TIME"
        ;;
    "Suspend")
        echo "$DBUS notify-send -u critical 'Scheduled Suspend' 'System will suspend in 2 minutes'" | at "$TIME" - 2 minutes
        echo "$DBUS notify-send -u critical 'Scheduled Suspend' 'System will suspend in 1 minute'" | at "$TIME" - 1 minute
        echo "hyprlock & sudo systemctl suspend" | at "$TIME"
        ;;
    "Reboot")
        echo "$DBUS notify-send -u critical 'Scheduled Reboot' 'System will reboot in 2 minutes'" | at "$TIME" - 2 minutes
        echo "$DBUS notify-send -u critical 'Scheduled Reboot' 'System will reboot in 1 minute'" | at "$TIME" - 1 minute
        echo "sudo systemctl reboot" | at "$TIME"
        ;;
esac

notify-send "Scheduled" "$ACTION at $TIME"

