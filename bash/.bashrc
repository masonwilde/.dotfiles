# .bashrc

source "$HOME/.sharedrc"

# Custom shell prompt
export PS1="\u@\h:\[\e[32m\]\W \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "

if [[ "$(uname -s)" == "Darwin" ]]; then
    export CLICOLOR=1
    export TERM=xterm-256color
    source ~/.git-completion.bash
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    source /usr/share/bash-completion/completions/git
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
