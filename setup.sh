#!/usr/bin/bash
set -e

# --- Symlinks ---
rm -f ~/.vimrc
ln -s ~/git/rcs/.vimrc ~/.vimrc
rm -f ~/.bashrc
ln -s ~/git/rcs/.bashrc ~/.bashrc
mkdir -p ~/.config/nvim
rm -f ~/.config/nvim/init.lua
ln -s ~/git/rcs/nvim/init.lua ~/.config/nvim/init.lua

# --- System packages ---
sudo add-apt-repository -y ppa:ultradvorka/ppa
sudo apt-get update
sudo apt-get install -y \
    hstr \
    vim-gtk3 \
    neovim \
    curl \
    build-essential cmake python3-dev python3-pip \
    mono-complete golang nodejs default-jdk npm \
    direnv

# --- Python tools ---
pip install pyright ruff requests

# --- vim: install plugins and build YouCompleteMe ---
# vim-plug bootstraps itself on first launch via .vimrc
vim -c "PlugInstall --sync" -c "qa!"
python3 ~/.vim/plugged/YouCompleteMe/install.py

# --- nvm ---
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh | bash

# --- pyenv ---
curl https://pyenv.run | bash

# --- Rust ---
curl https://sh.rustup.rs -sSf | sh -s -- -y
