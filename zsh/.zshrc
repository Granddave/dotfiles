export ZSH="$HOME/.oh-my-zsh"

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

setopt HIST_IGNORE_SPACE

plugins=(
    command-not-found
    direnv
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

bindkey '^ ' autosuggest-accept

# Theme inspired from 'simple'
local prompt_prefix
[ -n "$SSH_CONNECTION" ] && prompt_prefix="${prompt_prefix}$(hostname) "
[ -n "$dockerenv" ] && prompt_prefix="${prompt_prefix}docker "
local last_rc="%(?..%{$fg[red]%}%? %{$reset_color%})"
PROMPT='${last_rc}${prompt_prefix}%(!.%{$fg[red]%}.%{$fg[green]%})%~%{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%} '
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=" ✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"

[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh

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
alias ta="tig --all"
alias c="cargo"
alias j="just"
alias fd=fdfind
alias lsupg="sudo apt update && apt list --upgradable"
alias pubip="curl ipinfo.io/ip"
alias notes="(cd $NOTE_DIR; $EDITOR $NOTE_DIR)"
