export ZSH=/home/david/.oh-my-zsh

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

setopt HIST_IGNORE_SPACE
bindkey '^ ' autosuggest-accept

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Theme inspired from 'simple'
SSH_HOSTNAME=$([[ -n "$SSH_CONNECTION" ]] && echo "$(hostname) ")
local return_code="%(?..%{$fg[red]%}%? %{$reset_color%})"
PROMPT='$return_code$SSH_HOSTNAME%(!.%{$fg[red]%}.%{$fg[green]%})%~%{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%} '
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=" ✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"

if [[ -e /usr/share/fzf/key-bindings.zsh ]] && [[ -e /usr/share/fzf/completion.zsh ]]; then
    # For Arch based distros
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
elif [[ -e /usr/share/doc/fzf/examples/key-bindings.zsh ]] then
    # For Debian based distros
    source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

export VISUAL="/bin/vi -u NONE"
export EDITOR="nvim"
export PAGER="less"
export TERM="xterm-256color"

alias vi="$EDITOR"
alias vim="$EDITOR"

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Dev
source /usr/local/bin/virtualenvwrapper.sh

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
alias t="tig --date-order --all"
alias fd=fdfind
alias lsupg="sudo apt update && apt list --upgradable"
alias pubip="curl ipinfo.io/ip"
alias mkdate="mkdir $(date '+%Y-%m-%d')"

