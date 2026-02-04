set -U fish_greeting  # Disable welcome message

if type -q mise
    mise activate fish | source
end

if test -f "$HOME/.cargo/env.fish"
    source "$HOME/.cargo/env.fish"
end

set -x EDITOR "nvim"
set -x VISUAL "$EDITOR"
set -x PAGER "less"
set -x LNAV_EXP mouse  # Enable mouse support for lnav

if test -d "$HOME/sync/Life"
    set -x NOTE_DIR "$HOME/sync/Life"
else
    set -x NOTE_DIR "$HOME/Documents/Notes"
end
function notes
    cd $NOTE_DIR
    $EDITOR $NOTE_DIR
end
function daily
    cd $NOTE_DIR
    $EDITOR $NOTE_DIR/$(date +%Y-%m-%d).md
end


if status is-interactive
    bind -k nul accept-autosuggestion  # '-k nul': Ctrl+Space
    if type -q starship
        starship init fish | source
    end

    alias vi="$EDITOR"
    alias vim="$EDITOR"
    alias ls="eza"
    alias _ls="/usr/bin/ls --color=auto"
    alias g="git"
    alias r="lf"
    alias t="tig"
    alias ta="tig --all"
    alias lg="lazygit"
    alias c="cargo"
    alias j="just"
    alias here="open ."
    alias ip="ip -c"
    alias lsupg="sudo apt update && apt list --upgradable"
    alias pubip="curl ipinfo.io/ip"
    if type -q fdfind; and not type -q fd
        alias fd="fdfind"
    end
end
