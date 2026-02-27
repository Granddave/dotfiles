set -U fish_greeting  # Disable welcome message
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/bin"

type -q mise && mise activate fish | source
source "$HOME/.cargo/env.fish" 2>/dev/null
fish_add_path "$HOME/.local/bin"

set -x EDITOR "nvim"
set -x VISUAL "$EDITOR"
set -x PAGER "less"
set -x LNAV_EXP mouse  # Enable mouse support for lnav

if status is-interactive
    # Accept autosuggestions with Ctrl-Space
    set -l major (string split . $FISH_VERSION)[1]
    if test $major -ge 4
        bind ctrl-space accept-autosuggestion
    else
        bind -k nul accept-autosuggestion
    end

    type -q starship && starship init fish | source
    type -q zoxide && zoxide init fish | source
    if type -q fzf
        # Set up fzf key bindings and fuzzy completion
        set -gx FZF_DEFAULT_COMMAND "fdfind --type f --strip-cwd-prefix --hidden --follow --exclude .git"
        set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
        set -gx FZF_CTRL_T_OPTS "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
        fzf --fish | source
    end

    if type -q eza
        alias _ls="command ls --color=auto"
        alias ls="eza"
    else
        alias ls="ls --color=auto"
    end
    alias vi="$EDITOR"
    alias vim="$EDITOR"
    alias g="git"
    alias lf="yazi"
    alias t="tig"
    alias ta="tig --all"
    alias lg="lazygit"
    alias c="cargo"
    alias j="just"
    alias here="open ."
    alias ip="ip -c"
    alias pubip="curl ipinfo.io/ip"
    if type -q fdfind; and not type -q fd
        alias fd="fdfind"
    end
end
