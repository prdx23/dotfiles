#!/bin/bash

# make a directory and cd to it
mkcd() { 
    test -d "$1" || mkdir -p "$1" && cd "$1" 
}

# automatically do ls when using cd command
chpwd() {
    emulate -L zsh
    ls 
}

# open file in the main vim pane
v() { 
	vim --servername tmuxvim --remote "$1" 
	tmux select-window -t 'Dev'
	tmux select-pane -t 1
	if [ "$2" = "-d" ]
	then
		vcd
	fi
}

# open file in the main vim pane, in a new tab
vt() { 
	vim --servername tmuxvim --remote-tab "$1" 
	tmux select-window -t 'Dev'
	tmux select-pane -t 1
	if [ "$2" = "-d" ]
	then
		vcd
	fi
}

# send keys to the main vim pane
vk() { 
    vim --servername tmuxvim --remote-send "$1" 
}

# change vim's working directory to the one open the current shell
vcd() { 
    vim --servername tmuxvim --remote-send "<ESC>:cd $(pwd)<CR>"
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
# run test.html -c ~/utilities/commands.sh ref Chrome
run() { 
    find . -name "$1" | entr "${@:2}"
}

# minimize guake and refresh the active tab on chrome
ref() {
    xdotool key 'shift+BackSpace'
    xdotool windowactivate $(xdotool search --onlyvisible --class $1|head -1)
    xdotool key 'ctrl+r'
}

# excecute any function in this file using the cmd:
# ./commands.sh [function name] [function params]
# Ex: ./commands.sh ref Chrome
if [ "$1" != "" ]
then
    "$1" "${@:2}"
fi
