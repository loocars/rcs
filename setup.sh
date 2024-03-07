#!/usr/bin/bash

ln -s ~/git/rcs/.vimrc ~/.vimrc
rm ~/.bashrc
ln -s ~/git/rcs/.bashrc ~/.bashrc

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c "PluginInstall" -c "qa!"

sudo add-apt-repository -y ppa:ultradvorka/ppa
sudo add-apt-repository ppa:jonathonf/vim
sudo apt-get update
sudo aptitude install -y hstr
sudo aptitude install -y vim-gtk

sudo aptitude install -y build-essential cmake python3-dev
sudo aptitude install -y mono-complete golang nodejs default-jdk npm
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --all
cd ~/git/rcs

pip install requests
mkdir -p $HOME/.config/terminator/plugins
wget https://git.io/v5Zww -O $HOME"/.config/terminator/plugins/terminator-themes.py"
