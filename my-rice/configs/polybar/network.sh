#!/bin/bash
# Polybar Network Script
# Detects default interface and specific types

# Get default interface
DEFAULT_IFACE=$(ip route | grep '^default' | awk '{print $5}' | head -n1)

if [ -z "$DEFAULT_IFACE" ]; then
    echo "%{F#f7768e}󰤭 disconnected"
    exit 0
fi

# Check connection type
if [[ "$DEFAULT_IFACE" == wl* ]]; then
    # Wireless
    ESSID=$(iwgetid -r)
    echo "%{F#7aa2f7}󰤨 $ESSID"
elif [[ "$DEFAULT_IFACE" == ww* ]] || [[ "$DEFAULT_IFACE" == cdc* ]]; then
    # Modem / WWAN
    echo "%{F#bb9af7}󰈀 Modem"
else
    # Ethernet / Other
    echo "%{F#9ece6a}󰈁 Wired"
fi
