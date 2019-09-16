#!/bin/bash
#
# == Set alt drag ==
#
# Usage example to enable alt drag: ./set-alt-drag.sh 1

if [ "$XDG_CURRENT_DESKTOP" != "KDE" ]; then
    echo "Only KDE is supported" >&2
    exit 1
fi

if [ "$#" -ne 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: $0 [1,0]"
    exit 0
fi

COMMAND_KEY=
if [ "$1" -eq 1 ]; then
    COMMAND_KEY="Alt"
elif [ "$1" -eq 0 ]; then
    COMMAND_KEY="Meta"
else
    echo "$1 is not a valid option. Only '0' or '1'" >&2
    exit 1
fi

# Change config file
kwriteconfig5 --file ~/.config/kwinrc --group MouseBindings --key CommandAllKey $COMMAND_KEY

# Apply
dbus-send --type=signal --dest=org.kde.KWin /KWin org.kde.KWin.reloadConfig

