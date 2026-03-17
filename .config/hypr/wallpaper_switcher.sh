#!/bin/bash
WALLPAPER_DIR="$HOME/Downloads/WALLPAPERS"
THUMB_DIR="$HOME/.cache/wallpaper-thumbs"
mkdir -p "$THUMB_DIR"

# Check if thumbnails need to be generated
NEED_GENERATION=0
for img in "$WALLPAPER_DIR"/*; do
    filename=$(basename "$img")
    thumb="$THUMB_DIR/${filename}.png"
    if [ ! -f "$thumb" ]; then
        NEED_GENERATION=1
        break
    fi
done

# Show notification if generating
if [ $NEED_GENERATION -eq 1 ]; then
    notify-send "Wallpaper Selector" "Generating thumbnails, please wait..."
fi

# Generate high-quality thumbnails - preserve aspect ratio strictly
for img in "$WALLPAPER_DIR"/*; do
    filename=$(basename "$img")
    thumb="$THUMB_DIR/${filename}.png"
    if [ ! -f "$thumb" ]; then
        convert "$img" -resize 480x270^ -gravity Center -extent 480x270 "$thumb" 2>/dev/null
    fi
done

# Create temp file mapping index to filename
TEMP_MAP=$(mktemp)
INDEX=0
for img in "$WALLPAPER_DIR"/*; do
    filename=$(basename "$img")
    echo "$INDEX:$filename" >> "$TEMP_MAP"
    INDEX=$((INDEX + 1))
done

# Create rofi entries
TEMP_FILE=$(mktemp)
for img in "$WALLPAPER_DIR"/*; do
    filename=$(basename "$img")
    thumb="$THUMB_DIR/${filename}.png"
    printf " \0icon\x1f%s\n" "$thumb" >> "$TEMP_FILE"
done

# Show in rofi - 1 row, adaptive width
SELECTED_INDEX=$(cat "$TEMP_FILE" | rofi -dmenu -i \
    -show-icons \
    -theme-str 'inputbar { enabled: false; }' \
    -theme-str 'mainbox { children: [ listview ]; }' \
    -theme-str 'element-icon { size: 12em; }' \
    -theme-str 'element-text { enabled: false; }' \
    -theme-str 'listview { columns: 5; lines: 1; }' \
    -theme-str 'window { width: 1200px; height: 350px; }' \
    -format 'i')

rm "$TEMP_FILE"

# Exit if nothing selected
[ -z "$SELECTED_INDEX" ] && { rm "$TEMP_MAP"; exit 0; }

# Get filename from index
SELECTED=$(grep "^$SELECTED_INDEX:" "$TEMP_MAP" | cut -d: -f2)
rm "$TEMP_MAP"

WALLPAPER_PATH="$WALLPAPER_DIR/$SELECTED"

# Update shellwrapper
sed -i "s|^WALLPAPER=.*|WALLPAPER=\"$WALLPAPER_PATH\"|" ~/.config/hypr/shellwrapper.sh

source ~/.bashrc

# Generate Pywal colors
/home/rohan/.local/bin/wal -i "$WALLPAPER_PATH"

sleep 2

# Set wallpaper
killall swaybg 2>/dev/null
swaybg -i "$WALLPAPER_PATH" -m fill &

# Restart dunst with new colors
killall dunst 2>/dev/null
dunst &

# Force eww to reload CSS
touch ~/.config/eww/eww.scss

# Restart eww
killall -9 eww 2>/dev/null
eww daemon
sleep 1
eww open bar-window

# Reload Hyprland
hyprctl reload

notify-send "Wallpaper Changed" "Applied $SELECTED!"
