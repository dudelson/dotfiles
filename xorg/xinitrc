# set resolution
# on some systems this may not be necessary

# set these two variables to your desired width and height
DISPLAY_WIDTH=1920
DISPLAY_HEIGHT=1080

#MODELINE=$(cvt $DISPLAY_WIDTH $DISPLAY_HEIGHT | grep Modeline)
#NEW_MODE=$(echo $MODELINE | awk '{ print $2 }')
#xrandr --newmode $(echo $MODELINE | cut -d " " -f 2-)
# Be sure to replace "VGA-0" and "VGA-1" with your monitor(s) in the lines below
# Also if you wanna figure out how to script this part and make this a little
# more robust, that'd be cool too
xrandr --addmode VGA-0 $NEW_MODE
# You only need this line if you have a second monitor
#xrandr --addmode VGA-1 $NEW_MODE
# Single monitor setup
xrandr --output VGA-0 --mode $NEW_MODE
# Here's an example of a dual-monitor setup (from nedd)
#xrandr --output VGA-0 --mode $NEW_MODE --output VGA-1 --mode $NEW_MODE --right-of VGA-0
# And a triple-monitor setup (from datto)
# Here, the screen in the middle is marked as primary, and only the monitor
# on the left is specified, since Xorg automatically orders monitors from
# left to right, starting with the primary
#xrandr --output HDMI-0 --primary --output DisplayPort-0 --left-of HDMI-0

# start fcitx (japanese input)
# note that there's no need to check if the daemon is already running. The -r
# option does this for us
#fcitx -dr

# load custom keybindings
#xbindkeys

# swap caps lock and left ctrl
#setxkbmap -option "ctrl:swapcaps"

# start compositing manager
# uncomment this line if you want transparent terminals
#compton &

# merge in ~/.Xdefaults for nice terminal colors
xrdb -merge $HOME/.Xdefaults

# start awesome
exec awesome &>> $AWESOME_LOG_FILE

