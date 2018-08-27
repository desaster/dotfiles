ZSHRC_LOCAL="$HOME/.zshrc_local"
if [ -f "$ZSHRC_LOCAL" ]; then
    . "$ZSHRC_LOCAL"
fi

function venv3 {
    if [ -a "$1" ]
    then
        echo "File or directory already exists: $1"
        return
    fi
    virtualenv --python=/usr/bin/python3.4 "$1"
}

# If running interactively, then:
if [ "$PS1" ]; then
    PS1="\u@\h \w \$ "
    PS1="%n@%m %~ %# "

    alias ls='ls --color=auto'

    PALETTE_SCRIPT="$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"
    if [ -f "$PALETTE_SCRIPT" ]; then
        sh "$PALETTE_SCRIPT"
    fi

    setopt VI

    bindkey '' backward-kill-word
    bindkey '' backward-kill-word
fi

export VISUAL="vim"
export EDITOR="vim"

export PATH="$PATH:$HOME/bin"

alias tm="tmux attach-session -d -t main || tmux new -s main"

# vim: set sw=4 sts=4:
