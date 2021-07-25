if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [[ -z "$SSH_CONNECTION" ]]; then
    middle_click_scroll.py --device g203 1

    # Set key repeat speeds
    xset r rate 180 25
fi
