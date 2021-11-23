#!/usr/bin/env bash

if [ -e "$HOME/.Xmodmap" ]; then
    xmodmap "$HOME/.Xmodmap"
fi
