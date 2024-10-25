function venv3 {
    if [ -a "$1" ]
    then
        echo "File or directory already exists: $1"
        return
    fi
    virtualenv --python=/usr/bin/python3.4 "$1"
}

# Change the current directory for a tmux session, which determines
# the starting dir for new windows/panes:
function tmux-cwd {
    #tmux command-prompt -I $PWD -P "New session dir:" "attach -c %1"
    tmux command-prompt "attach -c %1 $PWD"
}

# If running interactively, then:
if [ "$PS1" ]; then
    PS1="%n@%m %2~ %# "

    alias ls='ls --color=auto'

    setopt VI

    autoload -U select-quoted select-bracketed surround
    zle -N select-quoted
    zle -N select-bracketed
    zle -N delete-surround surround
    zle -N add-surround surround
    zle -N change-surround surround

    for m in visual viopp; do
        for c in {a,i}{\',\",\`}; do
            bindkey -M $m $c select-quoted
        done
        for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
            bindkey -M $m $c select-bracketed
        done
    done

    bindkey -a cs change-surround
    bindkey -a ds delete-surround
    bindkey -a ys add-surround
    bindkey -M visual S add-surround

    bindkey '' backward-kill-word
    bindkey '' backward-kill-word

    bindkey "^R" history-incremental-search-backward

    # Use bash-like word definitions for navigation and operations
    autoload -Uz select-word-style
    select-word-style bash

    # Use C-w to kill back to the previous space
    zle -N backward-kill-space-word backward-kill-word-match
    zstyle :zle:backward-kill-space-word word-style space
    bindkey '^W' backward-kill-space-word

    # append completions to fpath
    fpath=(${HOME}/.zsh/completions $fpath)
    # initialise completions with ZSH's compinit
    autoload -Uz compinit && compinit

    # https://git-scm.com/book/sv/v2/Bilaga-A%3A-Git-in-Other-Environments-Git-in-Zsh
    # https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
    autoload -Uz vcs_info
    zstyle ':vcs_info:git*' formats " (%b)"
    precmd() {
        vcs_info
        if [[ -z ${vcs_info_msg_0_} ]]; then
            # no vcs info, show PS1 with full path
            PS1="%n@%m %~ %# "
        else
            # show less path components if we have vcs info
            PS1="%n@%m %2~${vcs_info_msg_0_} %# "
        fi
    }

fi

export WORDCHARS='*?_-.[]~=/&;&%^(){}<>' # this excludes /

export VISUAL="vim"
export EDITOR="vim"

export PATH="$PATH:$HOME/bin"

ZSHRC_LOCAL="$HOME/.zshrc_local"
if [ -f "$ZSHRC_LOCAL" ]; then
    . "$ZSHRC_LOCAL"
fi

# vim: set sw=4 sts=4:
