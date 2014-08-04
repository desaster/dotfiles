BASHRC_LOCAL="$HOME/.bashrc_local"
if [ -f "$BASHRC_LOCAL" ]; then
    . $HOME/.bashrc_local
fi

# If running interactively, then:
if [ "$PS1" ]; then
    PS1='\u@\h \w \$ '
    alias sc="screen -dr"
    alias sx="screen -x"
fi

export VISUAL="vim"
export EDITOR="vim"

PALETTE_SCRIPT="$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
if [ -f "$PALETTE_SCRIPT" ]; then
    sh "$PALETTE_SCRIPT"
fi

