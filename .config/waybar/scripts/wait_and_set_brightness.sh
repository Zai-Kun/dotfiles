#!/bin/bash

# This script waits for the wl-gammarelay-rs watch {bp} process to start and then sets the brightness to 50%

PROGRAM_NAME="wl-gammarelay-rs watch \{bp\}"

# Use a busy loop to check for the process
while true; do
    if pgrep -f -x "$PROGRAM_NAME" > /dev/null; then
        busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateBrightness d -0.5
        break
    fi
    # Use a small sleep interval for efficiency
    sleep 0.5
done
