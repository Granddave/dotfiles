eval "$(starship init zsh)"

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

setopt HIST_IGNORE_SPACE

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

bindkey '^ ' autosuggest-accept

# Direnv
eval "$(direnv hook zsh)"

export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"
export LNAV_EXP=mouse  # Enable mouse support for lnav

# Rust
[ -e "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Path
_try_add_path() {
    case ":${PATH}:" in
        *:"$1":*)
            # Already in PATH
            ;;
        *)
            [ -d "$1" ] && export PATH="$1:$PATH"
            ;;
    esac
}
_try_add_path "$HOME/bin"
_try_add_path "$HOME/.cargo/bin"
_try_add_path "$HOME/.local/bin"
_try_add_path "$HOME/go/bin"
_try_add_path "$HOME/.nvm/versions/node/v22.16.0/bin"
_try_add_path "/usr/local/go/bin"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

if [ -d "$HOME/sync/Life" ]; then
    export NOTE_DIR="$HOME/sync/Life"
else
    export NOTE_DIR="$HOME/Documents/notes"
fi

# Python virtual environments
if [ -f "$HOME/.local/bin/virtualenvwrapper.sh" ]; then
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Dev
    source $HOME/.local/bin/virtualenvwrapper.sh
fi

# Node version manager
nvm_load_environment() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}

open()
{
    while [ "$#" -gt 0 ]; do
        xdg-open $1 2>&1 > /dev/null
        shift
    done
}

note()
{
    mkdir -p "$NOTE_DIR"
    cd "$NOTE_DIR"
    local note_file="$NOTE_DIR/$(date '+%F').md"
    if ! [ -f "$note_file" ]; then
        echo "# $(date '+%F')\n" > "$note_file"
    fi

    $EDITOR '+normal Go' +startinsert "$note_file"
    echo "$note_file"
}

mkdate()
{
    mkdir $(date '+%F')
}

alias vi="$EDITOR"
alias vim="$EDITOR"
alias here="open ."
alias ls="ls --color=auto"
alias ip="ip -c"
alias g="git"
alias r="lf"
alias t="tig"
alias ta="tig --all"
alias c="cargo"
alias j="just"
alias fd=fdfind
alias lsupg="sudo apt update && apt list --upgradable"
alias pubip="curl ipinfo.io/ip"
alias notes="(cd $NOTE_DIR; $EDITOR $NOTE_DIR)"
