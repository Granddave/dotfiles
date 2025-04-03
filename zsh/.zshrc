eval "$(starship init zsh)"

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

setopt HIST_IGNORE_SPACE

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

bindkey '^ ' autosuggest-accept

[ -n $TMUX ] && export TERM="xterm-256color"

# Rust
[ -e "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Direnv
eval "$(direnv hook zsh)"

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
alias t="tig --all"
alias c="cargo"
alias j="just"
alias fd=fdfind
alias lsupg="sudo apt update && apt list --upgradable"
alias pubip="curl ipinfo.io/ip"
alias notes="(cd $NOTE_DIR; $EDITOR $NOTE_DIR)"
