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
* `sudo aptitude install hstr`

To install YouCompleteMe:
* `sudo aptitude install build-essential cmake vim-nox python3-dev`
* `sudo aptitude install mono-complete golang nodejs default-jdk npm`
* `cd ~/.vim/bundle/YouCompleteMe`
* `python3 install.py --all`

To change Terminator theme:
* Check the `TerminatorThemes` option under `terminator > preferences > plugins`
* Open the terminator context menu and select `Themes`
* Select theme
* Open `~/.config/terminator/config` and replace `[[default]]` theme with the selected one
