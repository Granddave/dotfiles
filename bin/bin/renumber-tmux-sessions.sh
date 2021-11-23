#!/usr/bin/env bash
#
# Renumbers Tmux sessions sequentially starting from 1
#
# Thanks to maximbaz
# https://github.com/tmux/tmux/issues/937
# https://github.com/maximbaz/dotfiles/commit/925a5b88a8263805a5a24c6198dad23bfa62f44d

SESSIONS=$(tmux ls | grep '^[0-9]\+:' | cut -f1 -d':' | sort -n)
NEW=1
for OLD in $SESSIONS
do
    if [[ "$OLD" =~ ^[0-9]+$ ]]; then
        tmux rename-session -t "$OLD" "$NEW"
        ((NEW++))
    fi
done
