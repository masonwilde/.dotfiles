# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Antigen
export ZSH_CACHE_DIR="${HOME}/.antigen/bundles/robbyrussell/oh-my-zsh/cache"
source ~/.antigen.zsh
antigen init ~/.antigenrc

source "$HOME/.sharedrc"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

_wt_branches() {
  local -a branches
  branches=(${(f)"$(git for-each-ref --format='%(refname:short)' refs/heads/ 2>/dev/null)"})
  (( ${#branches} )) && _describe -t branches 'branch' branches
}

# Route _default to branch completion only inside `wt switch`
_default() {
  if [[ $curcontext == *:wt-command-switch:* ]]; then
    _wt_branches
  else
    _files
  fi
}

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
