#!/usr/bin/env bash

read -p "* Install apt packages? [Y/n] " RESPONSE
if [[ "${RESPONSE:-Y}" =~ ^[yY]$ ]]; then
    xargs sudo apt-get install < apt-packages.txt
fi

read -p "* Install oh-my-zsh? [Y/n] " RESPONSE
if [[ "${RESPONSE:-Y}" =~ ^[yY]$ ]]; then
    echo "* Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    chsh -s /bin/zsh

    git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting
fi

read -p "* Install vim-plug? [Y/n] " RESPONSE
if [[ "${RESPONSE:-Y}" =~ ^[yY]$ ]]; then
    echo "* Installing vim-plug"
    if [[ ! -d $HOME/.vim/autoload/plug.vim ]]; then
        curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        echo "vim-plug already exists"
    fi
fi

read -p "* Stow directories? [Y/n] " RESPONSE
if [[ "${RESPONSE:-Y}" =~ ^[yY]$ ]]; then
    echo "* Starting to stow dotfiles..."
    DIRS="alacritty bin git tmux vim xmodmap zsh"
    for DIR in $DIRS;
    do
        if [[ -d $DIR ]]; then
            echo "* Stowing $DIR"
            stow $DIR
        fi
    done
fi

read -p "* Enabling weather service? [Y/n] " RESPONSE
if [[ "${RESPONSE:-Y}" =~ ^[yY]$ ]]; then
    if [ ! -e $HOME/.config/systemd/user/weather.service ]; then
        echo "! Tmux directory is not stowed"
    else
        systemctl --user daemon-reload
        systemctl --user enable weather.timer
        systemctl --user enable weather.service
    fi
fi

echo "* Done."
