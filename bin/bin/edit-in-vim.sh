#!/usr/bin/env bash
#
# Edit text fields in Neovim by selecting and copy the text followed by
# triggering a shortcut to run this script.
#
# Inspiration from https://snippets.martinwagner.co/2018-03-04/vim-anywhere

TMP_FILE=$(mktemp --suffix=edit-in-vim)
alacritty --title edit-in-vim --command nvim -c 'execute "normal \"+p"' "$TMP_FILE"
if [ -s "$TMP_FILE" ]; then
    xclip -selection c < "$TMP_FILE"
    xdotool key ctrl+v
fi
rm "$TMP_FILE"
