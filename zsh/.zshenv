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

# Rust
[ -e "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Python virtual environments
if [ -f "$HOME/.local/bin/virtualenvwrapper.sh" ]; then
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Dev
    source $HOME/.local/bin/virtualenvwrapper.sh
fi

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
