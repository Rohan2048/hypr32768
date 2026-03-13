#!/usr/bin/env bash

source ~/.bashrc
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

pgrep -x polkit-mate-authentication-agent-1 >/dev/null || /usr/libexec/polkit-mate-authentication-agent-1 &

WALLPAPER="$HOME/Downloads/WALLPAPERS/1209988-3840x2160-desktop-4k-glow-in-the-dark-background.jpg" #change as per your path of your preferred wallpaper
#WALL_LIVE="$HOME/Videos/Hidamari/mountains-under-blushing-skies.1920x1080.mp4" #change as per your path of your preferred video wallpaper

wal -i "$WALLPAPER"

killall swaybg 2>/dev/null
swaybg -i "$WALLPAPER" -m fill &

#Or set live wallpaper(But add a nice frame for wal -i)
#killall mpvpaper 2>/dev/null
#mpvpaper -o "no-audio loop" '*' "$WALL_LIVE" &

#Just comment out either sway or mpvpaper if any one of them not needed

touch ~/.config/eww/eww.scss

killall -9 eww 2>/dev/null
eww daemon
eww open bar-window

killall -9 dunst 2>/dev/null
dunst &

#Clipboard history (adjust number of items accordindly, or just omit --max-items <number> entirely)
wl-paste --watch cliphist --max-items 10 store &
