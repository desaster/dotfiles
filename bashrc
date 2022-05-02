BASHRC_LOCAL="$HOME/.bashrc_local"
if [ -f "$BASHRC_LOCAL" ]; then
    . $HOME/.bashrc_local
fi

function prompt_with_git {
    local __git_branch='`((git branch 2> /dev/null | grep -e ^* | sed -E s/^\\\\\*\ \(.+\)$/\(\\\\\1/ | xargs echo -n) && (git rev-parse 2>/dev/null && (git diff --no-ext-diff --quiet --exit-code 2> /dev/null || echo -en \*)) && echo -en \)\ )`'
    PS1="\u@\h \w $__git_branch\$ "
}

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

    if which git >/dev/null
    then
        prompt_with_git
    fi

    alias sc="screen -dr"
    alias sx="screen -x"
    alias ls='ls --color=auto'

    PALETTE_SCRIPT="$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"
    if [ -f "$PALETTE_SCRIPT" ]; then
        sh "$PALETTE_SCRIPT"
    fi

    # vi mode, done here instead of .inputrc since not all readline command
    # lines work well with it
    set -o vi
fi

export VISUAL="vim"
export EDITOR="vim"

alias tm="tmux attach-session -d -t main || tmux new -s main"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
