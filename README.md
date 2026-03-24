# rcs

Run `setup.sh` for a full automated install, or follow the steps below manually.

## Symlinks

```bash
rm -f ~/.vimrc && ln -s ~/git/rcs/.vimrc ~/.vimrc
rm -f ~/.bashrc && ln -s ~/git/rcs/.bashrc ~/.bashrc
mkdir -p ~/.config/nvim && ln -s ~/git/rcs/nvim/init.lua ~/.config/nvim/init.lua
```

## Secrets

`~/.bashrc.secrets` is sourced by `.bashrc` but not committed. Create it with:

```bash
echo "export GERRIT_TOKEN=<your_token>" >> ~/.bashrc.secrets
chmod 600 ~/.bashrc.secrets
```

## vim

vim-plug is bootstrapped automatically on first launch. YouCompleteMe is built via the plug `do` hook — if it fails, run manually:

```bash
sudo apt-get install -y build-essential cmake python3-dev
~/.vim/plugged/YouCompleteMe/install.py
```

## Neovim

lazy.nvim and all plugins install automatically on first launch. Requires pyright for Python LSP:

```bash
pip install pyright
```

## hstr

```bash
sudo add-apt-repository ppa:ultradvorka/ppa
sudo apt-get update && sudo apt-get install -y hstr
```
