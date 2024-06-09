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
sudo aptitude install -y vim-gtk3
sudo aptitude install -y curl

sudo aptitude install -y build-essential cmake python3-dev
sudo aptitude install -y mono-complete golang nodejs default-jdk npm

curl https://pyenv.run | bash
curl https://sh.rustup.rs -sSf | sh

sudo aptitude install -y direnv

cd ~/.vim/bundle/YouCompleteMe
python3 install.py --all
cd ~/git/rcs

pip install requests
mkdir -p $HOME/.config/terminator/plugins
wget https://git.io/v5Zww -O $HOME"/.config/terminator/plugins/terminator-themes.py"
