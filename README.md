# rcs

Create symlink to the rcs:
* `ln -s ~/git/rcs/.vimrc ~/.vimrc`
* `rm ~/.bashrc`
* `ln -s ~/git/rcs/.bashrc ~/.bashrc`

To install Vundle:
* `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
* Open vim
* Run `:PluginInstall`

To install hstr (Ubuntu):
* `sudo add-apt-repository ppa:ultradvorka/ppa`
* `sudo apt-get update`
* `sudo apt-get install hstr`

To install YouCompleteMe:
* `sudo aptitude install build-essential cmake3 python3-dev`
* `cd ~/.vim/bundle/YouCompleteMe`
* `python3 install.py --all`
