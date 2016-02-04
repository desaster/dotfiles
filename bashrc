BASHRC_LOCAL="$HOME/.bashrc_local"
if [ -f "$BASHRC_LOCAL" ]; then
    . $HOME/.bashrc_local
fi

function prompt_with_git {
    local __git_branch='`((git branch 2> /dev/null | grep -e ^* | sed -E s/^\\\\\*\ \(.+\)$/\(\\\\\1/ | xargs echo -n) && (git rev-parse 2>/dev/null && (git diff --no-ext-diff --quiet --exit-code 2> /dev/null || echo -en \*)) && echo -en \)\ )`'
    PS1="\u@\h \w $__git_branch\$ "
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

    PALETTE_SCRIPT="$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
    if [ -f "$PALETTE_SCRIPT" ]; then
        sh "$PALETTE_SCRIPT"
    fi
fi

export VISUAL="vim"
export EDITOR="vim"

alias tm="tmux attach-session -d -t main || tmux new -s main"
