#!/bin/bash
#  ╔══════════════════════════════════════════════════════════════════╗
#  ║                        Powermenu Script                          ║
#  ╚══════════════════════════════════════════════════════════════════╝

# Options (Nerd Fonts)
shutdown="⏻"
reboot="󰜉"
suspend="󰤄"
logout="󰍃"
lock="󰌾"

# Rofi command
rofi_cmd() {
    rofi -dmenu \
         -p "Power" \
         -mesg "Power Menu" \
         -theme ~/.config/rofi/powermenu.rasi
}

# Show menu
chosen=$(printf "%s\n%s\n%s\n%s\n%s" "$lock" "$suspend" "$logout" "$reboot" "$shutdown" | rofi_cmd)

# Exit if nothing selected (e.g. Escape pressed)
if [ -z "$chosen" ]; then
    exit 0
fi

# Execute based on choice
case $chosen in
    "$shutdown")
        systemctl poweroff
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$suspend")
        systemctl suspend
        ;;
    "$logout")
        bspc quit
        ;;
    "$lock")
        i3lock -c 000000
        ;;
esac
