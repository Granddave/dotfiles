#!/usr/bin/env bash

set -e

mkdir -p ~/.config/systemd/user

read -rp "* Install apt packages? [Y/n] " RESPONSE
if [[ "${RESPONSE:-Y}" =~ ^[yY]$ ]]; then
    xargs -a apt-packages.txt sudo apt-get install
fi

read -rp "* Install oh-my-zsh? [Y/n] " RESPONSE
if [[ "${RESPONSE:-Y}" =~ ^[yY]$ ]]; then
    echo "* Installing oh-my-zsh..."
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        chsh -s /bin/zsh

        git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting"
    else
        echo "oh-my-zsh already exists"
    fi
fi

read -rp "* Install vim-plug? [Y/n] " RESPONSE
if [[ "${RESPONSE:-Y}" =~ ^[yY]$ ]]; then
    echo "* Installing vim-plug"
    if [ ! -d "$HOME/.vim/autoload/plug.vim" ]; then
        curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        echo "vim-plug already exists"
    fi
fi

read -rp "* Install git-delta? [Y/n] " RESPONSE
if [[ "${RESPONSE:-Y}" =~ ^[yY]$ ]]; then
    if ! $(dpkg -l | grep -q git-delta); then
        VERSION="0.13.0"
        DEB="git-delta_${VERSION}_amd64.deb"
        curl -fLo $HOME/Downloads/$DEB https://github.com/dandavison/delta/releases/download/$VERSION/$DEB
        sudo dpkg -i $HOME/Downloads/$DEB
    else
        echo "git-delta already exists"
    fi
fi

read -rp "* Stow directories? [Y/n] " RESPONSE
if [[ "${RESPONSE:-Y}" =~ ^[yY]$ ]]; then
    echo "* Starting to stow dotfiles..."
    DIRS="alacritty bin git tmux vim xmodmap zsh"
    for DIR in $DIRS; do
        if [ -d "$DIR" ]; then
            echo "* Stowing $DIR"
            stow "$DIR"
        fi
    done
fi

read -rp "* Enabling weather service? [Y/n] " RESPONSE
if [[ "${RESPONSE:-Y}" =~ ^[yY]$ ]]; then
    if [ ! -e "$HOME/.config/systemd/user/weather.service" ]; then
        echo "! Tmux directory is not stowed"
    else
        systemctl --user daemon-reload
        systemctl --user enable weather.timer
        systemctl --user enable weather.service
        systemctl --user start weather.timer
    fi
fi

echo "* Done."
