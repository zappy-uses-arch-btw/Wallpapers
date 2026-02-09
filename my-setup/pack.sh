#!/bin/bash
#  ╔══════════════════════════════════════════════════════════════════╗
#  ║                     Pack Dotfiles for Deployment                 ║
#  ╚══════════════════════════════════════════════════════════════════╝
#  Run this to gather all your configs into a 'dotfiles' directory.
#  Then copy the 'my-rice' folder to your new machine.

set -e

OUTPUT_DIR="$HOME/my-rice"
CONFIG_DIR="$OUTPUT_DIR/configs"
BIN_DIR="$OUTPUT_DIR/bin"

echo "Packing dotfiles into $OUTPUT_DIR..."

mkdir -p "$CONFIG_DIR"
mkdir -p "$BIN_DIR"

# 1. Config Directories
DIRS=(
    bspwm
    sxhkd
    polybar
    rofi
    dunst
    picom
    alacritty
    tmux
    nvim
    yazi
    wallust
    startpage
)

for dir in "${DIRS[@]}"; do
    if [ -d "$HOME/.config/$dir" ]; then
        echo "Copying $dir..."
        cp -r "$HOME/.config/$dir" "$CONFIG_DIR/"
    else
        echo "Warning: $dir not found in ~/.config"
    fi
done

# 2. Individual Config Files
if [ -f "$HOME/.config/wallust.toml" ]; then
    echo "Copying wallust.toml..."
    cp "$HOME/.config/wallust.toml" "$CONFIG_DIR/"
fi

# 3. Scripts
if [ -f "$HOME/.local/bin/cwal" ]; then
    echo "Copying cwal script..."
    cp "$HOME/.local/bin/cwal" "$BIN_DIR/"
fi

# 4. Copy Setup Script
if [ -f "$HOME/my-setup/setup.sh" ]; then
    cp "$HOME/my-setup/setup.sh" "$OUTPUT_DIR/"
else
    # If setup.sh is active in editor but not saved or elsewhere
    echo "Warning: setup.sh not found in ~/my-setup/"
fi

echo ""
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║                        Packing Complete!                         ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo "Your rice is packed in: $OUTPUT_DIR"
echo "To deploy on a new machine:"
echo "1. Copy the 'my-rice' folder to the new machine."
echo "2. Run './setup.sh' inside that folder."
