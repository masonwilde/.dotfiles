# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"

source ~/.aliases
source ~/.functions

# Load Antigen
source ~/.antigen.zsh
antigen init ~/.antigenrc

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
