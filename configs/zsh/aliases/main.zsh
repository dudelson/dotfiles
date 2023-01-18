#############################################################################
##`````````````````````````````````````````````````````````````````````````##
##````````````````````````````````ALIASES``````````````````````````````````##
##`````````````````````````````````````````````````````````````````````````##
#############################################################################

###
# from zprezto utility module
###

alias cd='nocorrect cd'
alias cp='nocorrect cp'
alias gcc='nocorrect gcc'
alias grep='nocorrect grep'
alias ln='nocorrect ln'
alias mkdir='nocorrect mkdir -p'
alias mv='nocorrect mv'
alias rm='nocorrect rm'
alias find='noglob find'
alias ftp='noglob ftp'
alias history='noglob history'
alias scp='noglob scp'
alias _='sudo'
alias po='popd'
alias pu='pushd'

# lists the ten most used commands (from zprezto history module)
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"


###
# custom aliases
###

alias ls='ls --classify --group-directories-first'
alias la='ls -A'
alias sl='ls'

alias sctl='sudo systemctl'
alias uctl='systemctl --user'

# copy, move, delete
alias copy='rsync -rh --info="progress2"'
# prevent cp from clobbering files (the default)
alias cp="/usr/bin/cp -i"
alias zmv='noglob zmv -W'
# I keep confusing `rm` and `mv`...
alias rm="echo 'Please use delete instead.'"
alias delete="/usr/bin/rm"

# redefine common utilties
alias top='htop'
alias vim='nvim'
alias ec="emacsclient"

# diffing
alias kdiff='kitty +kitten diff'
alias sudovimdiff='SUDO_EDITOR="nvim -d" sudoedit'

# misc new commands
alias open='xdg-open 2> /dev/null'
alias pingtest='ping -c 3 8.8.8.8'

# copy shell command to clipboard
alias copycmd="fc -rl 1 | fzf | python -c 'import sys;print(\" \".join(sys.stdin.read().split()[1:]),end=\"\")' | wl-copy"
alias copyprev="fc -l -1 | python -c 'import sys;print(\" \".join(sys.stdin.read().split()[1:]),end=\"\")' | wl-copy"

# remove color from commands
alias nocolor="sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g'"

# fasd aliases
alias v='f -e nvim'
alias e='f -e emacsclient'
alias o='a -e xdg-open'
alias l='d -e "ls --group-directories-first --color=auto"'

# magic aliases (expand with <SPACE>)
typeset -Ag abbreviations
abbreviations=(
    "Ia"    "| awk"
    "Ic"    "| xclip -sel c"
    "Ig"    "| ag"
    "Ih"    "| head"
    "Il"    "| less"
    "It"    "| tail"
    "Is"    "| sort"
    "Iv"    "| ${VISUAL:-${EDITOR}}"
    "Iw"    "| wc"
    "Ix"    "| xargs"
)

# place temporary aliases and variables here

