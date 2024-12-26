#!/bin/bash

# Define the critical threshold
CRITICAL_THRESHOLD=80

# Get the current temperature (replace with the correct path for your system)
TEMPERATURE=$(cat /sys/class/thermal/thermal_zone0/temp)
TEMPERATURE_C=$((TEMPERATURE / 1000))

# Output the temperature only if it exceeds the critical threshold
if [ "$TEMPERATURE_C" -ge "$CRITICAL_THRESHOLD" ]; then
    echo "${TEMPERATURE_C}°C"
else
    echo ""
fi