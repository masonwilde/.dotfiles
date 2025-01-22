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
RUST_ENV_ALT="/usr/bin/cargo"
if [ -f $RUST_ENV ]; then
	. "$RUST_ENV"
elif ! [ -f $RUST_CARGO ]; then
	echo "WARNING (Rust): Missing $RUST_ENV"
fi
# Rust end

# Go
GO_PATH="/usr/local/go/bin"
GO_BIN="/usr/bin/go"
if [ -d "$GO_PATH" ]; then
	export PATH=$PATH:"$GO_PATH"
elif ! [[ -f $GO_BIN ]]; then
	echo "WARNING (Go): Missing $GO_PATH"
fi
# Go end

bindkey -v
eval "$(zoxide init zsh)"
