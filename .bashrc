# --- Environment (applies to all shells) ---
export EDITOR='nvim'
export VISUAL='nvim'
export VPN_CONNECT_TIMEOUT=8
export VPN_CONNECT_USE_SECRET_TOOLS=true
export GERRIT_USER=lukas.lengler
export LD_LIBRARY_PATH=/usr/local/lib

# Secrets kept out of version control
[ -f ~/.bashrc.secrets ] && . ~/.bashrc.secrets

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# --- History (hstr) ---
shopt -s histappend
export HISTCONTROL=ignorespace
export HISTFILESIZE=10000
export HISTSIZE=${HISTFILESIZE}
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"

# --- Shell options ---
shopt -s checkwinsize
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# --- Prompt ---
parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
show_virtual_env() {
    [ -n "$VIRTUAL_ENV" ] && echo "($(basename $VIRTUAL_ENV)) "
}
export -f show_virtual_env

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='$(show_virtual_env)${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '
else
    PS1='$(show_virtual_env)${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi

case "$TERM" in
    xterm*|rxvt*) PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1";;
esac

# --- Colors ---
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# --- General aliases ---
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias reloadbashrc='. ~/.bashrc'
alias omd='sudo omd'
alias lock='gnome-screensaver-command -l'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# --- check_mk ---
alias cmk='cd ~/git/check_mk/'
alias checks='cd ~/git/check_mk/checks'
alias checkm='cd ~/git/check_mk/checkman'
alias tests='cd ~/git/check_mk/tests'
alias zeug='cd ~/git/zeug_cmk'
alias gcm='cd ~/git/check_mk/ && git checkout master && git pull'
alias gcb='cd ~/git/check_mk_2.6.0 && git checkout 2.6.0 && git pull'
alias gcs='cd ~/git/check_mk_2.5.0 && git checkout 2.5.0 && git pull'
alias gco='cd ~/git/check_mk_2.4.0 && git checkout 2.4.0 && git pull'
alias gca='cd ~/git/check_mk_2.3.0 && git checkout 2.3.0 && git pull'
alias unittests='make -C tests/ test-unit'
alias first50files='git status | grep geändert | cut -d":" -f2 | cut -d" " -f8 | head -n50 | tr "\n" " "'
alias cdd='bazel run //packages/cmk-dev-deploy:cmk-dev-deploy-bin --'

# --- PATH ---
export PATH=$PATH:~/git/zeug_cmk/bin/
export PATH=$PATH:~/.local/bin/
export PATH=$PATH:~/.cargo/bin/
export PATH=$PATH:~/.local/share/bob/nvim-bin/
export PATH=$PATH:~/.codon/bin/

# --- hstr ---
alias hh=hstr
export HSTR_CONFIG=hicolor
export HSTR_TIOCSTI=n
function hstrnotiocsti {
    { READLINE_LINE="$( { </dev/tty hstr ${READLINE_LINE}; } 2>&1 1>&3 3>&- )"; } 3>&1;
    READLINE_POINT=${#READLINE_LINE}
}
if [[ $- =~ .*i.* ]]; then bind -x '"\C-r": "hstrnotiocsti"'; fi

# --- Completions ---
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# --- Tool integrations ---
command -v direnv &>/dev/null && eval "$(direnv hook bash)"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv &>/dev/null && eval "$(pyenv init -)"
