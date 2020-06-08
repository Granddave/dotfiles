#!/bin/bash

read -p "* Install fzf? [Y/n] " fzf
fzf=${fzf:-Y}
if [[ $fzf =~ ^[yY]$ ]]; then
    bin/bin/install-package fzf
fi

read -p "* Install oh-my-zsh? [Y/n] " zsh
zsh=${zsh:-Y}
if [[ $zsh =~ ^[yY]$ ]]; then
    echo "* Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    chsh -s /bin/zsh

    git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting
fi

if [[ ! -d ~/.vim/bundle/Vundle.vim ]]; then
    echo "* Installing vundle"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi


echo "* Starting to stow dotfiles..."
dirs="alacritty bin redshift tmux vim xmodmap zsh"
for dir in $dirs;
do
    if [[ -d $dir ]]; then
        echo "* Stowing $dir"
        stow $dir
    fi
done

echo "* Done."
