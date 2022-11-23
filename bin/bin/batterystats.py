#!/usr/bin/env python3

import sys


def status_string(props):
    status_to_icon = {
        "Charging": "🔺",
        "Discharging": "🔻",
        "Not charging": "🔸",
        "Full": "🔹",
    }
    status = props["POWER_SUPPLY_STATUS"]
    return status_to_icon.get(status, "?")


def remaining_battery_percentage(props):
    full = None
    now = None
    if "POWER_SUPPLY_ENERGY_NOW" in props:
        full = props["POWER_SUPPLY_ENERGY_FULL"]
        now = props["POWER_SUPPLY_ENERGY_NOW"]
    elif "POWER_SUPPLY_CHARGE_NOW" in props:
        full = props["POWER_SUPPLY_CHARGE_FULL"]
        now = props["POWER_SUPPLY_CHARGE_NOW"]
    else:
        return "?"
    return f"{int(now)/int(full)*100:.1f}"


def main():
    lines = None
    try:
        with open("/sys/class/power_supply/BAT0/uevent", "r") as f:
            lines = [l.strip() for l in f.readlines()]
    except:
        sys.exit(0)
    props = dict(l.split("=") for l in lines)
    status = status_string(props)
    percentage = remaining_battery_percentage(props)
    print(f"{status} {percentage}%")


if __name__ == "__main__":
    main()
