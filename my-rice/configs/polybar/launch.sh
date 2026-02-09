#!/bin/bash
#  ╔══════════════════════════════════════════════════════════════════╗
#  ║                     Polybar Launch Script                        ║
#  ╚══════════════════════════════════════════════════════════════════╝

# Terminate running instances
killall -q polybar

# Wait for processes to shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar
polybar main 2>&1 | tee -a /tmp/polybar.log & disown
