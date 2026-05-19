# .bashrc
#

# For Omarchy on WildeFramework13
export OMARCHY_RC="~/.local/share/omarchy/default/bash/rc"
if [ -f $OMARCHY_RC ]; then
	source $OMARCHY_RC
fi

source ~/.aliases
source ~/.functions

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

eval "$(zoxide init bash)"

set -o vi

# pnpm
export PNPM_HOME="/home/mason/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Rust
# Rust end

# Go
export PATH=$PATH:/usr/local/go/bin
# Go end

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init bash)"; fi
