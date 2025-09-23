#!/usr/bin/env bash

# Get current brightness
current=$(cat /sys/class/leds/asus::kbd_backlight/brightness)

if [ "$current" -eq 0 ]; then
    brightnessctl -d asus::kbd_backlight set 2
else
    brightnessctl -d asus::kbd_backlight set 0
fi
