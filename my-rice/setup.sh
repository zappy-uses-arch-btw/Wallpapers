#!/bin/bash
#  ╔══════════════════════════════════════════════════════════════════╗
#  ║                  BSPWM Rice Setup Script                         ║
#  ╚══════════════════════════════════════════════════════════════════╝
#  Run this script on a fresh Arch installation to set up the rice.

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_SRC="$DIR/configs"
BIN_SRC="$DIR/bin"

echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║              BSPWM Rice Installation Script                      ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo ""

# ─────────────────────────────────────────────────────────────────────
# Check if running as root
# ─────────────────────────────────────────────────────────────────────

if [ "$EUID" -eq 0 ]; then
    echo "Please do not run as root. Run as normal user."
    exit 1
fi

# ─────────────────────────────────────────────────────────────────────
# Install Dependencies
# ─────────────────────────────────────────────────────────────────────

echo "[1/6] Installing dependencies..."

PACKAGES=(
    # Base Xorg
    xorg-server
    xorg-xinit
    
    # Window Manager
    bspwm
    sxhkd
    
    # Bar & Launcher
    polybar
    rofi
    
    # Terminal & Tools
    alacritty
    tmux
    yazi
    thunar
    
    # Utilities
    picom-git
    dunst
    feh
    brightnessctl
    scrot
    i3lock
    network-manager-applet
    
    # Audio
    # Audio
    pipewire
    pipewire-pulse
    pipewire-alsa
    wireplumber
    pavucontrol
    
       
    # Editor
    neovim
    
    # Fonts & Icons
    ttf-jetbrains-mono-nerd
    papirus-icon-theme
    
    # Browser
    firefox
    
    # Misc
    imagemagick
    jq
    unzip
)

# Install packages
sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"

# Install wallust from AUR
if ! command -v wallust &> /dev/null; then
    echo "Installing wallust from AUR..."
    if command -v yay &> /dev/null; then
        yay -S --noconfirm wallust
    elif command -v paru &> /dev/null; then
        paru -S --noconfirm wallust
    else
        echo "Updating system and installing base-devel/git..."
        sudo pacman -S --needed --noconfirm base-devel git
        
        echo "Installing yay manually..."
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        (cd /tmp/yay && makepkg -si --noconfirm)
        
        echo "Installing wallust..."
        yay -S --noconfirm wallust-git
    fi
fi

# ─────────────────────────────────────────────────────────────────────
# Create Directories
# ─────────────────────────────────────────────────────────────────────

echo "[2/6] Creating directories..."

mkdir -p ~/.config
mkdir -p ~/.local/bin
mkdir -p ~/Pictures/Wallpapers
mkdir -p ~/Pictures/Screenshots

# ─────────────────────────────────────────────────────────────────────
# Backup Existing Configs
# ─────────────────────────────────────────────────────────────────────

echo "[3/6] Backing up existing configs..."

BACKUP_DIR="$HOME/.config/backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

if [ -d "$CONFIG_SRC" ]; then
    for dir in "$CONFIG_SRC"/*; do
        target="$(basename "$dir")"
        if [ "$target" == "wallust.toml" ]; then
             if [ -f "$HOME/.config/wallust.toml" ]; then
                 mv "$HOME/.config/wallust.toml" "$BACKUP_DIR/" 2>/dev/null || true
             fi
        elif [ -d "$HOME/.config/$target" ]; then
            mv "$HOME/.config/$target" "$BACKUP_DIR/" 2>/dev/null || true
        fi
    done
fi

echo "Backup saved to: $BACKUP_DIR"

# ─────────────────────────────────────────────────────────────────────
# Deploy Config files
# ─────────────────────────────────────────────────────────────────────

echo "[4/6] Deploying config files..."

if [ -d "$CONFIG_SRC" ]; then
    cp -r "$CONFIG_SRC"/* "$HOME/.config/"
    echo "Configs copied."
else
    echo "Warning: 'configs' directory not found in script folder!"
fi

if [ -d "$BIN_SRC" ]; then
    cp "$BIN_SRC"/* "$HOME/.local/bin/"
    chmod +x "$HOME/.local/bin/"*
    echo "Binaries copied."
else
    echo "Warning: 'bin' directory not found in script folder!"
fi

# ─────────────────────────────────────────────────────────────────────
# Set Permissions
# ─────────────────────────────────────────────────────────────────────

echo "[5/6] Setting permissions..."

find ~/.config/bspwm -name "*" -exec chmod +x {} \; 2>/dev/null || true
chmod +x ~/.config/polybar/launch.sh 2>/dev/null || true
chmod +x ~/.config/polybar/network.sh 2>/dev/null || true
chmod +x ~/.config/rofi/scripts/*.sh 2>/dev/null || true

# Add ~/.local/bin to PATH if not already
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    echo "Added ~/.local/bin to .bashrc"
fi

# ─────────────────────────────────────────────────────────────────────
# Final Steps
# ─────────────────────────────────────────────────────────────────────

echo "[6/6] Finalizing..."

if [ ! "$(ls -A ~/Pictures/Wallpapers 2>/dev/null)" ]; then
    echo "  Hint: Copy your wallpapers to ~/Pictures/Wallpapers/"
fi

echo ""
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║                    Installation Complete!                        ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo ""
echo "Please restart your computer or log out."
echo "Select 'bspwm' at the login screen."
echo ""
echo "Once logged in:"
echo "  1. Run 'cwal /path/to/wallpaper' to generate the theme."
echo "  2. Configure Firefox homepage to ~/.config/startpage/index.html"
echo ""
