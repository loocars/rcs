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
    curl \
    build-essential cmake python3-dev python3-pip \
    mono-complete golang default-jdk \
    direnv

# --- Rust (needed for bob) ---
if [ ! -d "$HOME/.cargo" ]; then
  curl https://sh.rustup.rs -sSf | sh -s -- -y
fi
source "$HOME/.cargo/env"

# --- Neovim via bob ---
cargo install bob-nvim
bob install stable
bob use stable

# --- Python tools ---
pip install pyright ruff requests setuptools

# --- vim: install plugins and build YouCompleteMe ---
# vim-plug bootstraps itself on first launch via .vimrc
vim -c "PlugInstall --sync" -c "qa!"
python3 ~/.vim/plugged/YouCompleteMe/install.py

# --- nvm ---
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh | bash
fi

# --- pyenv ---
if [ ! -d "$HOME/.pyenv" ]; then
  curl https://pyenv.run | bash
fi
