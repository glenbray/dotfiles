#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Speakers
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔊
# @raycast.packageName Audio

# Documentation:
# @raycast.description Toggle between G560 Gaming Speaker and MacBook Pro Speakers

BLUETOOTH_SPEAKER="G560 Gaming Speaker"
BUILTIN_SPEAKER="MacBook Pro Speakers"

current=$(SwitchAudioSource -c)

if [[ "$current" == "$BLUETOOTH_SPEAKER" ]]; then
    SwitchAudioSource -s "$BUILTIN_SPEAKER"
    echo "Switched to MacBook Pro Speakers"
else
    SwitchAudioSource -s "$BLUETOOTH_SPEAKER"
    echo "Switched to G560 Gaming Speaker"
fi
