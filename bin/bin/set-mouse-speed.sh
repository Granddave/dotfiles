#!/bin/bash
#
# == Set mouse speed ==
#
# Sets the mouse speed with xinput for a specified mouse.
# Only give the name of the mouse and the acceleration that you want.
#
# Author: David Isaksson (davidisaksson93@gmail.com)

if [ $# -ne 2 ]; then
    echo "Usage:    $0 <Mouse name> <Acceleration>"
    echo "Example:  $0 \"Logitech G203\" -0.5"
    echo ""
    echo "Run 'xinput --list' to figure out the name of the mouse that you want to configure."
    echo "Only a unique substring that identifies the mouse is required."
    exit 0
fi

MOUSE_NAME=$1
ACCEL=$2
ACCEL_PROP='libinput Accel Speed'
IDS=$(xinput --list | grep "pointer" | grep "$MOUSE_NAME" | grep -E -o 'id=[0-9]+' | grep -E -o '[0-9]+')
NUM=$(echo $IDS | wc -w)
echo "Found $NUM $MOUSE_NAME IDs"

for ID in ${IDS[@]}; do
    echo "Checking id $ID"
    if xinput --list-props $ID | grep "$ACCEL_PROP (" > /dev/null; then
        echo "Found prop for ID $ID"
        echo "Setting $ACCEL_PROP to $ACCEL"
        # Accel prop needs to be in single ticks. Any other way?
        /bin/bash -c "xinput set-prop $ID '$ACCEL_PROP' $ACCEL"
    fi
done
exit 0

