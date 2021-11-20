#!/usr/bin/env bash
#
# Prints a short battery status string

BATTERY_SOURCE_FILE="/sys/class/power_supply/BAT0/uevent"

remaining_battery_percentage()
{
    FULL=$(grep "POWER_SUPPLY_ENERGY_FULL=" "$BATTERY_SOURCE_FILE" | cut -d "=" -f2)
    NOW=$(grep "POWER_SUPPLY_ENERGY_NOW=" "$BATTERY_SOURCE_FILE" | cut -d "=" -f2)
    echo "scale=1; $NOW*100/$FULL" | bc -l
}

status_string()
{
    STATUS=$(grep "STATUS=" "$BATTERY_SOURCE_FILE" | cut -d "=" -f2)
    case "$STATUS" in
        "Unknown")
            echo "?";;
        "Charging")
            echo "🔺";;
        "Discharging")
            echo "🔻";;
        "Not charging")
            echo "🔸";;
        "Full")
            echo "Full";;
    esac
}

main()
{
    [ ! -f "$BATTERY_SOURCE_FILE" ] && exit 0
    echo "$(status_string) $(remaining_battery_percentage)%"
}

main
