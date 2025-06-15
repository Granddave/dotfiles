#!/usr/bin/env zsh
if [ -z "$SSH_CONNECTION" ] && ! grep -q WSL /proc/sys/kernel/osrelease; then
    middle_click_scroll.py --device g203 1
    xset r rate 180 25  # Set key repeat speeds: 180ms delay, 25 keys/sec repeat rate
    xmodmap ~/.Xmodmap  # Load custom key mappings
fi
