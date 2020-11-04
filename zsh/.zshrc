export ZSH=/home/david/.oh-my-zsh

ZSH_THEME="simple"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

if [[ -e /usr/share/fzf/key-bindings.zsh ]] && [[ -e /usr/share/fzf/completion.zsh ]]; then
    # For Arch based distros
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
elif [[ -e /usr/share/doc/fzf/examples/key-bindings.zsh ]] then
    # For Debian based distros
    source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

bindkey '^ ' autosuggest-accept

export DEBEMAIL="davidisaksson93@gmail.com"
export DEBFULLNAME="David Isaksson"

if [[ -z "$SSH_CONNECTION" ]]; then
    export VISUAL="nvim"
else
    export VISUAL="vim"
    export PROMPT="$(hostname) $PROMPT"
fi
export EDITOR="$VISUAL"
export PAGER="less"
export TERM=xterm-256color

alias vi="$EDITOR"
alias vim="$EDITOR"

open()
{
    if [ "$#" -ne 1 ]; then
        echo "open only support one argument"
        return
    fi
    xdg-open $1 2>&1 > /dev/null
}

toggle()
{
    if pgrep $1 2>&1 > /dev/null; then
        pkill $1 2>&1 > /dev/null
    else
        "$@" 2>&1 > /dev/null
    fi
}

alias here="open ."
alias ls="ls --color=auto"
alias ip="ip -c"
alias r="ranger"
alias lsupg="sudo apt update && apt list --upgradable"
alias pubip="curl ipinfo.io/ip"
alias mkdate="mkdir $(date '+%Y-%m-%d')"

