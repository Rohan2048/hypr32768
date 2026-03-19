# Hyprland Setup Requirements
Install on Fedora with: sudo dnf install -y $(grep -v '^#' requirements.txt | tr '\n' ' ') # or install via sudo dnf one by one as per the requirements
If you use any other OS, you can still find most of the packages but additional search is required...

# Core Wayland/Hyprland
```
hyprland
hyprlock
swaybg
```
# Video Wallpaper
```
mpvpaper
```
# Bar
```
eww
```
# Notifications
```
dunst
```
# App Launcher
```
rofi-wayland #or 'rofi' if rofi-wayland isn't available
```
# Theming
```
python3-pywal
qt6ct
```
# Authentication
```
mate-polkit
```
# Audio/Media
```
playerctl
pipewire-utils
mpv
mpv-mpris
```
# Brightness
```
brightnessctl
```
# Screenshots
```
grim
slurp
```
# Fonts
```
fontconfig
```
# Clipboard history
```
cliphist
```
# Plugins for hyprland decorations
```
hyprland-plugin-hyprexpo
```

In bash, to find where the plugin is added, do in terminal : 

```bash
find / -name "*.so" 2>/dev/null | grep hyprexpo
```

Path may exist as: "/usr/lib64/hyprland/libhyprexpo.so". If yes, add this as follows in hyprland.conf:

```conf
plugin = /usr/lib64/hyprland/libhyprexpo.so
```
Otherwise it can be defined in plugin as per the path its saved.

# In hyprland.conf:
```conf
bind = $mainMod, tab, hyprexpo:expo, toggle
```
# You can also add under hyprland.conf:

```conf
plugins { 
    hyprexpo { 
    columns = 3 
    gap_size = 5 
    bg_col = rgb(111111) 
    workspace_method = center current
    enable_gesture = false
    gesture_distance = 300
    }
}
```

# Thumbnail generator(for wallpapers):
```
ImageMagick
```

# ADDITIONAL NOTES:

1)You must manually place the config folders (or create) as follows:
```
dunst: place this at ~/.config/dunst
eww: place this at ~/.config/eww
fontconfig: place this at ~/.config/fontconfig
hypr: place this at ~/.config/hypr
rofi: place this at ~/.config/rofi
sounds(optional, you can add your own): place this at ~/.config/sounds
wal: place this at ~/.config/wal
```

2)You may need to manually find the packages incase a distro doesnt offer the exact package. Package names may differ.

3)Things that each of the files handle:
```
dunst: Your notification functions
eww: The bar that can be configured as preferred and as per the eww syntax
fontconfig: Deals with rendering aspects for fonts
hypr: The main component that handles all the rules, keybindings, etc
rofi: Configured to show App menu, powermenu and clipboard history of the last 10 entries(additional options in shellwrapper.sh under /.config/hypr)
sounds(optional, you can add your own): your own set of sounds can be included here
wal: Pywal related configs that allows the system to apply accent colors from the wallpapers you set
```
4)You may need to open and define your own directories, which are mostly defined as variables from the scripts provided.

5)Certain aspects like blur may not work if the associated mesa drivers are not included.

6)For a video to be used as a live wallpaper, you can define the directory of the preferred video under ```shellwrapper.sh``` (in ```~/.config/hypr```). However, you must provide one frame of the video for pywal to generate wallpaper colors.

7)Similarly, background music can be defined as preference under ```autoplay.sh```(in ```~/.config/hypr```)

8)You may need to check the displays your system uses by the bash command: ```hyprctl monitors``` and do entries accordingly(under ```hdmi.sh``` in ```~/.config/hypr```).

9)Keybindings you may need:
```
1) System

Super + Escape — Power menu
Super + L — Lock screen
Super + M — Exit Hyprland (commented out)

2) Apps

Super + Q — Terminal (Konsole)
Super + E — File Manager (Dolphin)
Super + R — App launcher (Rofi)

3) Windows

Super + C — Close window
Super + V — Toggle floating
Super + F — Fullscreen
Super + Shift + F — Maximize
Super + J — Toggle split
Super + Arrow keys — Move focus

4) Workspaces

Super + 1-9, 0 — Switch workspace
Super + Shift + 1-9, 0 — Move window to workspace
Super + N — Minimize to special workspace
Super + Shift + N — Show minimized
Alt + Tab — Workspace overview (hyprexpo)
3-finger swipe — Switch workspaces

5) Media

Super + T — Toggle music
Alt + N — Next track
Alt + P — Previous track
Media keys — Play/pause/next/prev

6) Display

Alt + S — HDMI display options
Alt + R — Revert to laptop screen

7) Utilities

Super + S — Screenshot
Super + P — Clipboard history
Super + Shift + W — Wallpaper switcher
Volume/Brightness keys — Self explanatory(the usual keys to adjust volume and brightness)
```
Additionally, in ```hypr.conf```(in ```~/.config/hypr```), ```Super``` is defined as a variable ```$mainMod```.

10) The file manager and the terminal can anyways be adjusted as preference.


# Using schedule_action.sh(under ~/.config/hypr/):
## Steps
1. Install `at`:
2. Enable and start the daemon:
   `sudo systemctl enable atd && sudo systemctl start atd`
3. Add NOPASSWD rule via `sudo visudo`:
   - Fedora/RHEL/Arch/openSUSE:
     ```
     %wheel ALL=(ALL) NOPASSWD: /usr/bin/systemctl suspend, /usr/bin/systemctl poweroff, /usr/bin/systemctl reboot
     ```
   - Ubuntu/Debian:
     ```
     %sudo ALL=(ALL) NOPASSWD: /usr/bin/systemctl suspend, /usr/bin/systemctl poweroff, /usr/bin/systemctl reboot
     ```

### Usage
Press `Super + Shift + Escape` to open the scheduler.
1. Choose action: Shutdown, Suspend, or Reboot
2. Enter time in HH:MM format (24hr)
3. System will notify 2 minutes and 1 minute before executing
4. Use "Cancel Scheduled" to cancel any pending action
