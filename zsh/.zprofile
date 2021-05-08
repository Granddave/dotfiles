if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [[ -z "$SSH_CONNECTION" ]]; then
    for id in $(get-mouse-id.sh 'Logitech G203'); do
        set-mouse-speed.sh 0 $id >/dev/null
        middle-click-scroll 1 $id >/dev/null
    done

    # Set key repeat speeds
    xset r rate 180 25
fi
