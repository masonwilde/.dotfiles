# .bashrc
#
source ~/.aliases
source ~/.functions

# Custom shell prompt
export PS1="\u - \[\e[32m\]\W \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "

uname_var="$(uname -s)"
# If on MacOS
if [[ $uname_var =~ Darwin ]]; then
    # Brew
    alias gimme='brew install'
    # Set CLICOLOR if you want Ansi Colors in iTerm2 
    export CLICOLOR=1
    # Set colors to match iTerm2 Terminal Colors
    export TERM=xterm-256color
    # Git completion
    source ~/.git-completion.bash
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ $uname_var =~ "Arch" ]]; then # Probably on Linux...most likely Arch
    # Pacman
    alias gimme='sudo pacman -S'
    # Git completion
    source /usr/share/git/completion/git-completion.bash
elif [[ $uname_var =~ "Linux" ]]; then # Probably on Linux...most likely Ubuntu
    # Apt
    alias gimme='sudo apt install'
    # Git completion
    source /usr/share/git/completion/git-completion.bash
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
