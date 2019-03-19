PATH="$HOME/bin/:$HOME/.local/bin/:$PATH:/usr/sbin"

for id in $(get-mouse-id.sh 'Logitech G203'); do
    set-mouse-speed.sh -0.7 $id >/dev/null
    middle-click-scroll $id >/dev/null
done

# Set caps lock to <CTRL>
/usr/bin/setxkbmap -option "ctrl:nocaps"

if type albert > /dev/null && ! pgrep albert >/dev/null 2>&1; then
    albert &
fi

