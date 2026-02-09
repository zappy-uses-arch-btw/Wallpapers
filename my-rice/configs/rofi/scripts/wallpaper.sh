#!/bin/bash
#  ╔══════════════════════════════════════════════════════════════════╗
#  ║                     Wallpaper Selector Script                    ║
#  ╚══════════════════════════════════════════════════════════════════╝

# Wallpaper directory
WALL_DIR="$HOME/Pictures/Wallpapers"

# Create directory if it doesn't exist
mkdir -p "$WALL_DIR"

# Get list of wallpapers (files only)
# Using null delimiter for safety, but rofi needs newlines
mapfile -t wallpapers_list < <(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort)

# Check if wallpapers exist
if [ ${#wallpapers_list[@]} -eq 0 ]; then
    notify-send "Wallpaper" "No wallpapers found in $WALL_DIR"
    exit 1
fi

# Generate rofi input with icons
# Format: Display Name\0icon\x1fAbsolute Path
rofi_input=""
for img in "${wallpapers_list[@]}"; do
    filename=$(basename "$img")
    rofi_input+="${filename}\0icon\x1f${img}\n"
done

# Show rofi menu
# -show-icons is enforced here and in theme
chosen=$(echo -e "$rofi_input" | rofi -dmenu -p "󰸉" -theme ~/.config/rofi/wallpaper.rasi)

# If selection made, apply wallpaper
if [ -n "$chosen" ]; then
    wallpaper="$WALL_DIR/$chosen"
    if [ -f "$wallpaper" ]; then
        "$HOME/.local/bin/cwal" "$wallpaper"
    fi
fi
