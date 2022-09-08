[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"

if [ -d "$HOME/sync/Life/daily" ]; then
    export NOTE_DIR="$HOME/sync/Life/daily"
else
    export NOTE_DIR="$HOME/Documents/notes"
fi
