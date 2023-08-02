#
# .bashrc
#

uname_var="$(uname -s)"
if [[ uname_var =~ "Darwin\n" ]]; then
    # Set CLICOLOR if you want Ansi Colors in iTerm2 
    export CLICOLOR=1

    # Set colors to match iTerm2 Terminal Colors
    export TERM=xterm-256color
fi

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\u - \[\e[32m\]\W \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "

if [[ var =~ "Darwin\n" ]]; then
    source ~/.git_completion.sh
else
    source /usr/share/git/completion/git-completion.bash
fi
export BASH_SILENCE_DEPRECATION_WARNING=1
