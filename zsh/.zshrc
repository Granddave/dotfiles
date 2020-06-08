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
bindkey '^ ' autosuggest-accept

DEBEMAIL="davidisaksson93@gmail.com"
DEBFULLNAME="David Isaksson"
export DEBEMAIL DEBFULLNAME

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export VISUAL="vim"
export EDITOR="vim"
export TERM=xterm-256color

alias vi="vim"
alias ls="ls --color=auto"
alias ip="ip -c"
alias lsupg="sudo apt update && apt list --upgradable"
alias here="xdg-open . 2>&1 > /dev/null"
alias pubip="curl ipinfo.io/ip"

mkdate()
{
    mkdir $(date "+%Y-%m-%d")
}
