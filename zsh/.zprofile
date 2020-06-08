PATH="$HOME/bin/:$HOME/.local/bin/:$PATH"

for id in $(get-mouse-id.sh 'Logitech G203'); do
    set-mouse-speed.sh -0.7 $id >/dev/null
    middle-click-scroll 1 $id >/dev/null
done

# Set caps lock to <CTRL>
/usr/bin/setxkbmap -option "ctrl:nocaps"

