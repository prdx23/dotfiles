#!/bin/zsh


# this script acts as the bridge to use neovim with godot
# it runs neovim in server mode with a gui via neovide, makes sure only one
# instance of neovide exists and brings neovide into focus when needed by godot
#
# optional dependency:
# gnome extension - https://github.com/ickyicky/window-calls
#
# godot setup:
# - godot-preferences/text-editor/external
#     exec path = "/home/prdx/.config/zsh/godot_neovide_bridge.sh"
#     exec flags = "{project} {file} {col} {line}"
# - godot-preferences/text-editor/behavior
#     restore script on load = false
#     auto reload scripts on external changes = true



NEOVIDE_PATH="/home/prdx/Documents/software/neovide-linux-x86_64/neovide"
SOCK_PATH="/tmp/neovide-server.sock"

if [ "$1" = "direct" ]; then
    "$NEOVIDE_PATH" --fork "$2"
    exit 0
fi

if [ "$#" -lt 2 ]; then
    echo "Error: expected at least 2 arguments"
    exit 1
fi

PROJECT_PATH="$1"
FILE_PATH="$2"
COL="${3:-0}"
LINE="${4:-0}"

if ! pgrep -f "$NEOVIDE_PATH" > /dev/null; then
    cd "$PROJECT_PATH" || exit 1
    "$NEOVIDE_PATH" --fork "$FILE_PATH" -- --listen "$SOCK_PATH"
    exit 0
fi

nvim --server "$SOCK_PATH" --remote-send "<C-\\><C-N>:e ${FILE_PATH}<CR>:call cursor($((LINE+1)),$COL)<CR>"

set_winid() {
    WINID=$( \
        gdbus call --session --dest org.gnome.Shell \
        --object-path /org/gnome/Shell/Extensions/Windows \
        --method org.gnome.Shell.Extensions.Windows.List \
        | cut -c 3- | rev | cut -c4- | rev \
        | sed "s/'//g; s/\\\\\"/\\\"/g" \
        | jq -r -c '.[] | select(.wm_class == "neovide") | .id' \
    )
}

activate() {
    gdbus call --session --dest org.gnome.Shell \
    --object-path /org/gnome/Shell/Extensions/Windows \
    --method org.gnome.Shell.Extensions.Windows.Activate \
    "$WINID"
}

move_to_workspace() {
    gdbus call --session --dest org.gnome.Shell \
    --object-path /org/gnome/Shell/Extensions/Windows \
    --method org.gnome.Shell.Extensions.Windows.MoveToWorkspace \
    "$WINID" "$CURRENT_WORKSPACE"
}

CURRENT_WORKSPACE=$(wmctrl -d | grep '\*' | awk '{print $1}')
set_winid
move_to_workspace
activate

