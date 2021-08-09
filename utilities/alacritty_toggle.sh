#!/bin/bash

PID=$(pgrep --exact alacritty)

if [ -z "$PID" ]; then
    # echo 'not found!'
    alacritty &
    exit 0
fi

WINDOWID=$(xdotool search --pid $PID)
IS_VISIBLE=true

[ -z $(xdotool search --onlyvisible --pid $PID) ] && IS_VISIBLE=false

[ $(xdotool getwindowfocus) != "$WINDOWID" ] && {
    if [ $IS_VISIBLE == true ]; then
        # echo 'to front!'
        xdotool windowactivate --sync $WINDOWID
        wmctrl -F -r "Alacritty" -e 0,0,0,-1,-1
        wmctrl -F -r "Alacritty" -b add,fullscreen
    else
        # echo 'show!'
        xdotool windowmap --sync $WINDOWID
        wmctrl -F -r "Alacritty" -e 0,0,0,-1,-1
        wmctrl -F -r "Alacritty" -b add,fullscreen
    fi
    exit 0
}

# echo 'hide!'
xdotool windowunmap $WINDOWID
