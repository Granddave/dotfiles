#!/bin/bash
#
# == Get mouse id ==
#
# Usage example: ./get-mouse-id "Logitech G203"
# If no arguments are given, all pointer devices IDs are printed.

if [ "$#" -ne 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage:   $0 <Mouse name>"
    echo "Example: $0 \"Logitech G203\""
    exit 0
fi

xinput --list | grep "pointer" | grep "$1" | grep -E -o 'id=[0-9]+' | grep -E -o '[0-9]+'
