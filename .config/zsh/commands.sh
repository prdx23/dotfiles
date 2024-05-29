#!/bin/bash


alias hs='history 1 | cut -c 8- | sort -u | rg'



# make a directory and cd to it
mkcd() {
    test -d "$1" || mkdir -p "$1" && cd "$1"
}

# automatically do ls when using cd command
chpwd() {
    emulate -L zsh
    ls
}

# helper to easily tunnel a port to a specific server
live() {
    if [[ $1 == "glitchcomet" ]]; then
        secret=$GCLIVE_SECRET
        server_port=2142
    elif [[ $1 == "andrepeat" ]]; then
        secret=$ARLIVE_SECRET
        server_port=2140
    else
        echo "server $1 not available"
        return
    fi

    url="localhost.$1.com"
    echo "-> Tunnelling port $2 to $url"
    bore local $2 --to $url --secret=$secret --port $server_port
}

# open a project folder from anywhere
goto() {
    dir=$(fd \
        --type directory \
        --base-directory ~ \
        --search-path Code \
        --no-require-git \
        --color always \
    | fzf \
        --ansi \
        --reverse \
        --inline-info \
        --height=20% \
        --keep-right \
    )
    # --search-path .config \

    if [[ ! -z "$dir" ]]; then
        cd "$HOME/$dir"
    fi
}

# zle -N goto
# bindkey '^g' goto



# open file/files in current git project in nvim
code() {
    project_root=$(git rev-parse --show-toplevel)
    if [[ -z "$project_root" ]]; then
        return
    fi

    fd \
        --type file \
        --base-directory $project_root \
        --color always \
    | fzf \
        --ansi \
        --reverse \
        --multi \
        --inline-info \
        --height=20% \
        --keep-right \
        --print0 \
    | xargs -0 -o -i -r nvim --cmd "cd $project_root" $project_root/{}
}


# open file in the main vim pane
v() {
    # vim --servername tmuxvim --remote "$1" 
    nvr $1
    tmux select-window -t 'Dev'
    tmux select-pane -t 1
    if [ "$2" = "-d" ]
    then
        vcd
    fi
}

# open file in the main vim pane, in a new tab
# vt() { 
# 	vim --servername tmuxvim --remote-tab "$1" 
# 	tmux select-window -t 'Dev'
# 	tmux select-pane -t 1
# 	if [ "$2" = "-d" ]
# 	then
# 		vcd
# 	fi
# }

# send keys to the main vim pane
vk() {
    vim --servername tmuxvim --remote-send "$1"
}

# change vim's working directory to the one open the current shell
vcd() {
    # vim --servername tmuxvim --remote-send "<ESC>:cd $(pwd)<CR>"
    nvr --remote-send "<ESC>:cd $(pwd)<CR>"
}

# split current pane vertically with pwd
sd() {
    tmux split-window -c "#{pane_current_path}"
}

# split current pane horizantly with pwd
sr() {
    tmux split-window -h -c "#{pane_current_path}"
}

# watch for changes in given file and excecute given command
# run [file/regex] [-c] [command]
# exmaples:
# run test.py -c python test.py
# run test.scm racket test.scm
# run test.py python -m doctest test.py
# run test.html -c ~/utilities/commands.sh singlemonitor Chrome
# run test.html -c ~/utilities/commands.sh multimonitor Firefox
run() {
    find . -name "$1" | entr "${@:2}"
}

# minimize guake and refresh the active tab on browser
# singlemonitor() {
#     xdotool key 'shift+BackSpace'
#     xdotool windowactivate $(xdotool search --onlyvisible --class $1|head -1)
#     xdotool key 'ctrl+r'
# }

# switch to browser on other monitor, refresh, and switch back
# multimonitor() {
#     xdotool windowactivate $(xdotool search --onlyvisible --desktop=0 --class $1|head -1)
#     xdotool key 'ctrl+r'
#     xdotool windowactivate $(xdotool search --onlyvisible --class Guake|head -1)
# }

# autoserve() {
#     browser-sync start -s -w -f . --host $(host -I) --port 9000 --no-open --no-inject-changes
# }

# excecute any function in this file using the cmd:
# ./commands.sh [function name] [function params]
# Ex: ./commands.sh singlemonitor Chrome
# if [ "$1" != "" ]
# then
#     "$1" "${@:2}"
# fi
