#############################################################################
##`````````````````````````````````````````````````````````````````````````##
##``````````````````````````````ZSH OPTIONS````````````````````````````````##
##`````````````````````````````````````````````````````````````````````````##
#############################################################################
# from zprezto environment module
setopt BRACE_CCL          # Allow brace character class list expansion.
setopt COMBINING_CHARS    # Combine zero-length punctuation characters (accents)
                          # with the base character.
setopt RC_QUOTES          # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt MAIL_WARNING     # Don't print a warning message if a mail file has been accessed.
setopt LONG_LIST_JOBS     # List jobs in the long format by default.
setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process.
setopt NOTIFY             # Report status of background jobs immediately.
unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
unsetopt HUP              # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS       # Don't report on jobs when shell exit.

# from zprezto history module
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing non-existent history.

# from zprezto directory module
setopt AUTO_CD              # Auto changes to a directory without typing cd.
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME        # Push to home directory when no argument is given.
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt AUTO_NAME_DIRS       # Auto add variable-stored paths to ~ list.
setopt MULTIOS              # Write to multiple descriptors.
setopt EXTENDED_GLOB        # Use extended globbing syntax.
unsetopt CLOBBER            # Do not overwrite existing files with > and >>.
                            # Use >! and >>! to bypass.
# from zprezto utility module
setopt CORRECT

# from zprezto completion module
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt PATH_DIRS           # Perform path search even on command names with slashes.
setopt AUTO_MENU           # Show completion menu on a succesive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor.


#############################################################################
##`````````````````````````````````````````````````````````````````````````##
##`````````````````````````````ENV VARIABLES```````````````````````````````##
##`````````````````````````````````````````````````````````````````````````##
#############################################################################
export HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"   # The path to the history file.
export HISTSIZE=10000                           # The maximum number of events to save in the internal history.
export SAVEHIST=10000                           # The maximum number of events to save in the history file.
export EDITOR='vim'
export LANG='en_US.UTF-8'
#export LANGUAGE='en_US.UTF-8'
#export LC_ALL='en_US.UTF-8'


#############################################################################
##`````````````````````````````````````````````````````````````````````````##
##````````````````````````````````ALIASES``````````````````````````````````##
##`````````````````````````````````````````````````````````````````````````##
#############################################################################
# from zprezto utility module
alias cd='nocorrect cd'
alias cp='nocorrect cp'
alias gcc='nocorrect gcc'
alias grep='nocorrect grep'
alias ln='nocorrect ln'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir -p'
alias mv='nocorrect mv'
alias rm='nocorrect rm'

alias find='noglob find'
alias ftp='noglob ftp'
alias history='noglob history'
alias scp='noglob scp'

alias _='sudo'
alias ls='ls --group-directories-first --color=auto'
alias po='popd'
alias pu='pushd'
alias la='ls -A'
alias sl='ls'

# lists the ten most used commands (from zprezto history module)
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# custom aliases
alias feh='feh --scale-down'
alias top='htop'
alias pacman='yaourt'
alias sudovimdiff='SUDO_EDITOR=vimdiff sudoedit'

# fasd aliases
alias v='f -e vim'
alias o='a -e xdg-open'
alias l='a -e ls'
alias c='a -e cs'

#############################################################################
##`````````````````````````````````````````````````````````````````````````##
##```````````````````````````````FUNCTIONS`````````````````````````````````##
##`````````````````````````````````````````````````````````````````````````##
#############################################################################
# from the zprezto utility module
# makes a directory and changes to it.
function mkdcd {
    [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# Changes to a directory and lists its contents.
function cs {
    builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pushes an entry onto the directory stack and lists its contents.
function pushdls {
    builtin pushd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}
    
# Pops an entry off the directory stack and lists its contents.
function popdls {
    builtin popd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}


#############################################################################
##`````````````````````````````````````````````````````````````````````````##
##````````````````````````````EXTERNAL MODULES`````````````````````````````##
##`````````````````````````````````````````````````````````````````````````##
#############################################################################
# colors!!!11!
autoload -U colors && colors

# smart urls 
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Load and initialize the completion system, ignoring insecure dirs
autoload -Uz compinit && compinit -i

# uncomment the next three lines to enable powerline
#if [[ -r /usr/lib/python3.4/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
#    source /usr/lib/python3.4/site-packages/powerline/bindings/zsh/powerline.zsh
#fi

# fasd
eval "$(fasd --init auto)"

#############################################################################
##`````````````````````````````````````````````````````````````````````````##
##`````````````````````````````````MISC````````````````````````````````````##
##`````````````````````````````````````````````````````````````````````````##
#############################################################################
# emacs line editing
bindkey -e
# prompt
export PROMPT="%M %{$fg[blue]%}%~%{$reset_color%} %# "


