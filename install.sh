#!/usr/bin/env bash

echo "Starting to stow dotfiles..."

for dir in `ls .`;
do
    if [[ -d $dir ]]; then # Check if $dir is a directory
        echo "Stowing $dir"
        stow $dir
    fi
done

echo "Done."
