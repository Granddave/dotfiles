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
PROMPT_PREFIX="$([ -n "$SSH_CONNECTION" ] && echo "$(hostname) ")$([ -n "$dockerenv" ] && echo "docker ")"
local return_code="%(?..%{$fg[red]%}%? %{$reset_color%})"
PROMPT='$return_code$PROMPT_PREFIX%(!.%{$fg[red]%}.%{$fg[green]%})%~%{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%} '
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=" ✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"

[ -n $TMUX ] && export TERM="xterm-256color"

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
