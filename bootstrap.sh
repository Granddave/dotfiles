#!/bin/bash

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install python3-pip
/usr/bin/env python3 -m pip install ansible
echo "$PATH" | grep "$HOME/.local/bin" || ( echo 'PATH=$PATH:$HOME/.local/bin' >> "$HOME/.bashrc" )
