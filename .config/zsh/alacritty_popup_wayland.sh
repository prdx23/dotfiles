#!/bin/bash
# requires gnome extension - https://github.com/ickyicky/window-calls


activate() {
    gdbus call --session --dest org.gnome.Shell  \
    --object-path /org/gnome/Shell/Extensions/Windows  \
    --method org.gnome.Shell.Extensions.Windows.Activate  \
    $WINID
}

minimize() {
    gdbus call --session --dest org.gnome.Shell  \
    --object-path /org/gnome/Shell/Extensions/Windows  \
    --method org.gnome.Shell.Extensions.Windows.Minimize  \
    $WINID
}

move_to_monitor() {
    if [ "$(xrandr --listmonitors | grep Monitors | cut -c 11-)" = "2" ]; then
        # echo 'move to monitor!'
        gdbus call --session --dest org.gnome.Shell  \
        --object-path /org/gnome/Shell/Extensions/Windows  \
        --method org.gnome.Shell.Extensions.Windows.Move  \
        $WINID 2560 0
    fi
}

move_to_workspace() {
    gdbus call --session --dest org.gnome.Shell  \
    --object-path /org/gnome/Shell/Extensions/Windows  \
    --method org.gnome.Shell.Extensions.Windows.MoveToWorkspace  \
    $WINID $CURRENT_WORKSPACE
}

set_winid() {
    WINID=$( \
        gdbus call --session --dest org.gnome.Shell  \
        --object-path /org/gnome/Shell/Extensions/Windows  \
        --method org.gnome.Shell.Extensions.Windows.List  \
        | cut -c 3- | rev | cut -c4- | rev  \
        | jq -c '.[] | select(.wm_class == "Alacritty") | .id' \
    )
}


if [ -z "$(pgrep --exact alacritty)" ]; then
    # echo 'run!'
    alacritty &
    sleep 0.2
    set_winid
    echo $WINID
    move_to_monitor
    # minimize
    exit 0
fi

IS_VISIBLE=$( \
    gdbus call --session --dest org.gnome.Shell  \
    --object-path /org/gnome/Shell/Extensions/Windows  \
    --method org.gnome.Shell.Extensions.Windows.List  \
    | cut -c 3- | rev | cut -c4- | rev  \
    | jq -c '.[] | select(.wm_class == "Alacritty") | .focus' \
)

set_winid

if [ "$IS_VISIBLE" = "true" ]; then
    # echo 'hide!'
    CURRENT_WORKSPACE=0
    minimize
    move_to_workspace
else
    # echo 'show!'
    CURRENT_WORKSPACE=$(wmctrl -d | grep '*' | cut -c 1)
    move_to_workspace
    activate
fi

echo $CURRENT_WORKSPACE
echo $WINID
echo $IS_VISIBLE
