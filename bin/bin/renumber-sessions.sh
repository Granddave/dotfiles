#!/usr/bin/env bash
#
# Thanks to maximbaz
# https://github.com/tmux/tmux/issues/937
# https://github.com/maximbaz/dotfiles/commit/925a5b88a8263805a5a24c6198dad23bfa62f44d

sessions=$(tmux ls | grep '^[0-9]\+:' | cut -f1 -d':' | sort)

new=1
for old in $sessions
do
  tmux rename-session -t $old $new
  ((new++))
done
