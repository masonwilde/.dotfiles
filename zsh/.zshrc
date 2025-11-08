# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# For Omarchy on WildeFramework13
OMARCHY_RC="~/.local/share/omarchy/default/bash/rc"
if [ -f $OMARCHY_RC ]; then
	source $OMARCHY_RC
fi

# Load Antigen
export ZSH_CACHE_DIR="${HOME}/.antigen/bundles/robbyrussell/oh-my-zsh/cache"
source ~/.antigen.zsh
antigen init ~/.antigenrc

source "$HOME/.aliases"
source "$HOME/.functions"

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

if [ -f ~/.workrc ]; then
	source ~/.workrc
else
	eval "$(direnv hook zsh)"
	export PATH="~/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
fi

bindkey -v
eval "$(zoxide init zsh)"

export PATH=~/.local/bin/:$PATH
export PATH="$HOME/.cargo/bin:$PATH"

export COMPACT_LOGGING=true

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
