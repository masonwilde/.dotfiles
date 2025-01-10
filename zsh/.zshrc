# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

source ~/.aliases
source ~/.functions

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

# load zsh-completions
autoload -U compinit && compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pnpm
export PNPM_HOME="/home/mason/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Rust
RUST_ENV="$HOME/.cargo/env"
if [ -f $RUST_ENV ]; then
	. "$RUST_ENV"
else
	echo "WARNING (Rust): Missing $RUST_ENV"
fi
# Rust end

# Go
GO_PATH="/usr/local/go/bin"
if [ -d "$GO_PATH" ]; then
	export PATH=$PATH:"$GO_PATH"
else
	echo "WARNING (Go): Missing $GO_PATH"
fi
# Go end

bindkey -v
eval "$(zoxide init zsh)"
