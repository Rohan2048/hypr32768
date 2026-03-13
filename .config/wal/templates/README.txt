REMEMBER TO SYMLINK DUNSTRC TO SYNC THE NOTIFICATION COLOURS WITH THE WALLPAPER:

# 1. Delete the old dunstrc file (if it exists)
rm ~/.config/dunst/dunstrc

# 2. Create a symlink pointing to the Pywal-generated file
ln -s ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
