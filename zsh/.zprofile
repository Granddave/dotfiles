if [ -z "$SSH_CONNECTION" ] && ! grep -q WSL /proc/sys/kernel/osrelease; then
    middle_click_scroll.py --device g203 1

    # Set key repeat speeds
    xset r rate 180 25
fi
