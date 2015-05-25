# set resolution
xrandr --newmode "1600x900_60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
xrandr --addmode VGA-0 "1600x900_60.00"
xrandr --output VGA-0 --mode "1600x900_60.00"

# merge in ~/.Xdefaults for nice terminal colors
xrdb -merge $HOME/.Xdefaults

# start awesome
awesome

