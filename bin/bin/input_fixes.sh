#!/usr/bin/env zsh
if [ -z "$SSH_CONNECTION" ] && ! grep -q WSL /proc/sys/kernel/osrelease; then
    middle_click_scroll.py --device g203 1
    xset r rate 150 25  # Set key repeat speeds: Initial delay, repeat rate
    xmodmap ~/.Xmodmap  # Load custom key mappings
fi
