#!/usr/bin/env bash

CLANGD="$HOME/.local/share/nvim/lsp_servers/clangd/clangd/bin/clangd"
PORT=4444
while true; do
    echo "Starting Clangd..."
    sleep 1
    socat tcp-listen:$PORT,reuseaddr exec:"$CLANGD --background-index"
    echo "Clangd stopped"
done
