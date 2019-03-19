#!/bin/bash
#
# == Set mouse speed ==
#
# Sets the mouse speed with xinput for a specified device ID.

if [ "$#" -ne 2 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage:    $0 <Acceleration> <Device IDs"
    echo "Example:  $0 -0.5 13 14"
    echo ""
    echo "Run 'xinput --list' to figure out the IDs of the mouse that you want to configure."
    echo "Or run my other utility command get-mouse-id, which gets the IDs by device name."
    exit 0
fi

ACCEL=$1
shift
for ID in "$@"; do
    if xinput --list-props $ID | grep "libinput Accel Speed (" > /dev/null; then
        echo "Found accel prop for ID $ID"
        xinput set-prop $ID 'libinput Accel Speed' $ACCEL
    fi
done
