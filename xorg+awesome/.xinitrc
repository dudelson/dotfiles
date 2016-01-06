# set resolution
# on some systems this may not be necessary

# set these two variables to your desired width and height
DISPLAY_WIDTH=1200
DISPLAY_HEIGHT=1600

MODELINE=$(cvt $DISPLAY_WIDTH $DISPLAY_HEIGHT | grep Modeline)
NEW_MODE=$(echo $MODELINE | awk '{ print $2 }')
xrandr --newmode $(echo $MODELINE | cut -d " " -f 2-)
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



# swap caps lock and left ctrl
#setxkbmap -option "ctrl:swapcaps"

# merge in ~/.Xdefaults for nice terminal colors
xrdb -merge $HOME/.Xdefaults

# start awesome
export AWESOME_LOG_FILE=~/.cache/awesome/awesome.log
exec awesome &>> $AWESOME_LOG_FILE

