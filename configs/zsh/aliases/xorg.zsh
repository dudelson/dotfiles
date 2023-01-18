
# use `maim` to screenshot the entire screen to a file
# screenshot the selected area to a file
alias maims='maim -s -p 1 -c 1,0,0,0.5 --nokeyboard'
# screenshot the entire screen to the clipboard
alias maimc='notify-send "Taking screenshot to clipboard in 3 seconds...";
             maim -d 3 --format=png /dev/stdout | xclip -selection c -t image/png'
# screenshot the selected area to the clipboard
alias maimsc='maim -s -p 1 -c 1,0,0,0.5 --nokeyboard --format=png /dev/stdout | xclip -selection c -t image/png'
# screenshot specifically for org-download
alias maimdl='maim -s -p 1 -c 1,0,0,0.5 --nokeyboard /tmp/screenshot.png'

alias feh='feh --scale-down'

