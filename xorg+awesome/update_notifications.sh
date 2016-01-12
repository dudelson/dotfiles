#!/bin/sh

# update_notifications.sh: information about packages available to be updated

###############################################################################
##                               CONFIGURATION                               ##
###############################################################################

# location of file that lists packages we want to watch
WATCHED_PACKAGES_FILE="/home/david/.watched_packages"

# update notification colors, in order of priority (high to low):
# watched package update available: cyan
# 20 updates or greater: red
# 10 updates or greater: orange
# these are configurable

WATCHED_PACKAGE_AVAILABLE_COLOR=16d4de
TWENTY_PLUS_UPDATES_COLOR=ff0000
TEN_PLUS_UPDATES_COLOR=ff7300

###############################################################################
##                             END CONFIGURATION                             ##
###############################################################################

UPDATES=$(checkupdates)
N_UPDATES=$(echo "$UPDATES" | wc -l)
if [ $(echo "$UPDATES" | wc -w) -eq 0 ]; then
    N_UPDATES=0
fi

WATCHED_PACKAGES=$(cat $WATCHED_PACKAGES_FILE)

# check for watched packages in the list of packages available to be updated
WATCHED_PACKAGE_FOUND=0
for u in $UPDATES; do
    for w in $WATCHED_PACKAGES; do
	if [ "$w" == "\#*" ]; then
	    continue
	fi

	if [ $u == $w ]; then
	    WATCHED_PACKAGE_FOUND=1
	    break
	fi
    done

    if [ $WATCHED_PACKAGE_FOUND -eq 1 ]; then
	break
    fi
done

if [ $WATCHED_PACKAGE_FOUND -eq 1 ]; then
    PKG_NTFCTN_FMT_STR="<span color=\"#$WATCHED_PACKAGE_AVAILABLE_COLOR\">$N_UPDATES</span> | "
elif [ $N_UPDATES -ge 20 ]; then
    PKG_NTFCTN_FMT_STR="<span color=\"#$TWENTY_PLUS_UPDATES_COLOR\">$N_UPDATES</span> | "
elif [ $N_UPDATES -ge 10 ]; then
    PKG_NTFCTN_FMT_STR="<span color=\"#$TEN_PLUS_UPDATES_COLOR\">$N_UPDATES</span> | "
# do not show the widget if there are no updates
elif [ $N_UPDATES -eq 0 ]; then
    PKG_NTFCTN_FMT_STR=""
else
    PKG_NTFCTN_FMT_STR="$N_UPDATES | "
fi

WIDGET_MARKUP="package_update_notification_widget:set_markup('$PKG_NTFCTN_FMT_STR')" 
CUR_DATE=$(date "+%a %b %d %H:%M:%S")
echo "[$CUR_DATE] update_notifications: the widget markup code is \"$WIDGET_MARKUP\"" >> $AWESOME_LOG_FILE
echo $WIDGET_MARKUP | awesome-client

