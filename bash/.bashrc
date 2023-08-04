#
# .bashrc
#
# Generally Helpful Aliases
# Directories
alias la='ls -a'
alias ls='ls --color=auto'
alias la='ls -d -a --color=auto'
alias ..='cd ..'
alias cd..='cd ..'
# Git
alias gitp='git pull origin main'
alias gitc='git commit -m'
alias gita='git commit --amend'
alias gitfukt='git reset HEAD --hard'
## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
# Diff
alias diff='colordiff'
# handy short cuts #
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'
# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'
# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
## pass options to free ##
alias meminfo='free -m -l -t'
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
## Get server cpu info ##
alias cpuinfo='lscpu'
## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
## this one saved by butt so many times ##
alias wget='wget -c'

# Git Helpers
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Change the shell prompt
export PS1="\u - \[\e[32m\]\W \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "

uname_var="$(uname -s)"
# If on MacOS
if [[ uname_var =~ "Darwin\n" ]]; then
    # Brew
    alias gimme='brew install'
    # Set CLICOLOR if you want Ansi Colors in iTerm2 
    export CLICOLOR=1
    # Set colors to match iTerm2 Terminal Colors
    export TERM=xterm-256color
    # Git completion
    source ~/.git_completion.sh
else # Probably on Linux...most likely Arch
    # Pacman
    alias gimme='sudo pacman -S'
    # Git completion
    source /usr/share/git/completion/git-completion.bash
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

