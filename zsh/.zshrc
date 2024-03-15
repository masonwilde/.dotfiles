# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

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

# Go
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# get machine's ip address
alias ip="ipconfig getifaddr en0"

# edit global zsh configuration
alias zshconfig="vim ~/.zshrc"
# reload zsh configuration
alias zshsource="source ~/.zshrc"
# reload zsh configuration
alias ohmyzsh="cd ~/.oh-my-zsh"

# navigate to global ssh directory
alias sshhome="cd ~/.ssh"
# edit global ssh configuration
alias sshconfig="vim ~/.ssh/config"

# edit global git configuration
alias gitconfig="vim ~/.gitconfig"

# git aliases
alias gits="git status"
alias gitd="git diff"
alias gitl="git lg"
alias gita="git add ."
alias gitc="cz commit"

alias loc="npx sloc --format cli-table --format-option head --exclude 'build|\.svg$\.xml' ./"

# load zsh-completions
autoload -U compinit && compinit

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pnpm
export PNPM_HOME="/Users/masonwilde/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
