# run after .zshrc for login shells only

# start dropbox daemon if not already running
if ! [[ -n $(ps -C dropbox --no-headers) ]]; then
    $HOME/.dropbox-dist/dropboxd &
fi

# start x if not already running
if ! [[ -n $(ps -C startx --no-headers) ]]; then
    startx &
fi
