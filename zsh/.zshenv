_try_add_path() {
    [ -d "$1" ] && PATH="$1:$PATH"
}

_try_add_path "$HOME/bin"
_try_add_path "$HOME/.local/bin"
_try_add_path "$HOME/go/bin"
_try_add_path "$HOME/.nvm/versions/node/v18.17.1/bin"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"

if [ -d "$HOME/sync/Life" ]; then
    export NOTE_DIR="$HOME/sync/Life"
else
    export NOTE_DIR="$HOME/Documents/notes"
fi

# Enable mouse support for lnav
export LNAV_EXP=mouse
