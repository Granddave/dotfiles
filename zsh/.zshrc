export ZSH="$HOME/.oh-my-zsh"

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

setopt HIST_IGNORE_SPACE

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

bindkey '^ ' autosuggest-accept

# Theme inspired from 'simple'
SSH_HOSTNAME=$([ -n "$SSH_CONNECTION" ] && echo "$(hostname) ")
local return_code="%(?..%{$fg[red]%}%? %{$reset_color%})"
PROMPT='$return_code$SSH_HOSTNAME%(!.%{$fg[red]%}.%{$fg[green]%})%~%{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%} '
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=" ✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"

if [ -f /usr/share/fzf/key-bindings.zsh ] && [ -f /usr/share/fzf/completion.zsh ]; then
    # For Arch based distros
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
elif [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
    # For Debian based distros
    source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

open()
{
    if [ "$#" -ne 1 ]; then
        echo "open only support one argument"
        return
    fi
    xdg-open $1 2>&1 > /dev/null
}

alias vi="$EDITOR"
alias vim="$EDITOR"

alias here="open ."
alias ls="ls --color=auto"
alias ip="ip -c"
alias r="ranger"
alias t="tig --date-order --all"
alias fd=fdfind
alias lsupg="sudo apt update && apt list --upgradable"
alias pubip="curl ipinfo.io/ip"
alias mkdate="mkdir $(date '+%Y-%m-%d')"
