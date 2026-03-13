#!/usr/bin/env bash

# -----------------------------------------------
# HDMI OUTPUT SCRIPT
# Uncomment the section you want and run the script
# Run: bash ~/.config/hypr/hdmi.sh
# -----------------------------------------------

# Monitor names (confirmed via hyprctl monitors)
# Internal: eDP-1    — 1920x1080@60.05 scale 1.5
# External: HDMI-A-1 — 1920x1080@74.97 Acer HA220Q
# You may need to check monitors via hyprctl monitors and change accordingly...

INTERNAL="eDP-1"
EXTERNAL="HDMI-A-1"

# -----------------------------------------------
# OPTION 1: Laptop screen only (disable HDMI)
# -----------------------------------------------
#hyprctl keyword monitor "$INTERNAL,1920x1080@60.05,0x0,1.5"
#hyprctl keyword monitor "$EXTERNAL,disable"
#killall -9 eww 2>/dev/null && eww daemon
#eww open bar-window
#killall -9 dunst 2>/dev/null && dunst &

# -----------------------------------------------
# OPTION 2: External display only (disable laptop screen)
# -----------------------------------------------
hyprctl keyword monitor "$EXTERNAL,1920x1080@74.97,0x0,1.5"
hyprctl keyword monitor "$INTERNAL,disable"
killall -9 eww 2>/dev/null && eww daemon
eww open bar-window
killall -9 dunst 2>/dev/null && dunst &

# -----------------------------------------------
# OPTION 3: Mirror (same content on both screens)
# -----------------------------------------------
#hyprctl keyword monitor "$INTERNAL,1920x1080@60.05,0x0,1.5"
#hyprctl keyword monitor "$EXTERNAL,1920x1080@74.97,0x0,1,mirror,$INTERNAL"
#killall -9 eww 2>/dev/null && eww daemon
#eww open bar-window
#killall -9 dunst 2>/dev/null && dunst &

# -----------------------------------------------
# OPTION 4: Extend (HDMI to the right of laptop)
# -----------------------------------------------
#hyprctl keyword monitor "$INTERNAL,1920x1080@60.05,0x0,1.5"
#hyprctl keyword monitor "$EXTERNAL,1920x1080@74.97,1280x0,1.5"
#killall -9 eww 2>/dev/null && eww daemon
#eww open bar-window
#killall -9 dunst 2>/dev/null && dunst &

notify-send "Display" "HDMI config applied"
