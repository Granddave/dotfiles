#!/usr/bin/env bash

echo "Stowing dotfiles..."

for dir in `ls .`;
do
    if [[ -d $dir ]]; then # If dir really is a directory
        ( stow $dir ) 
    fi
done

echo "Done."
