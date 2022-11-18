export ZSH="$HOME/.oh-my-zsh"

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

setopt HIST_IGNORE_SPACE

plugins=(
    command-not-found
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

[ -n $TMUX ] && export TERM="xterm-256color"

[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh

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
alias r="lf"
alias t="tig --all"
alias fd=fdfind
alias lsupg="sudo apt update && apt list --upgradable"
alias pubip="curl ipinfo.io/ip"
alias notes="$EDITOR $NOTE_DIR"
