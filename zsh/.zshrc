# Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"

source ~/.aliases
source ~/.functions

# Load Antigen
source ~/.antigen.zsh
antigen init ~/.antigenrc

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
