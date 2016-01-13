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
export LC_ALL='en_US.UTF-8'
export PATH=$PATH:/home/david/.gem/ruby/2.2.0/bin
export AWESOME_LOG_FILE=/home/david/.cache/awesome/awesome.log
# configure fcitx (used for japanese input)
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
