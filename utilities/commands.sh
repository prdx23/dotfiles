# make a directory and cd to it
mkcd() { test -d "$1" || mkdir -p "$1" && cd "$1" }

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
		vpwd
	fi
}

# open file in the main vim pane, in a new tab
vt() { 
	vim --servername tmuxvim --remote-tab "$1" 
	tmux select-window -t 'Dev'
	tmux select-pane -t 1
	if [ "$2" = "-d" ]
	then
		vpwd
	fi
}

# send keys to the main vim pane
vk() { vim --servername tmuxvim --remote-send "$1" }

# change vim's working directory to the one open the current shell
vcd() { vim --servername tmuxvim --remote-send "<ESC>:cd $(pwd)<CR>"}

# split current pane vertically with pwd
sd() { tmux split-window -c "#{pane_current_path}" }

# split current pane horizantly with pwd
sr() { tmux split-window -h -c "#{pane_current_path}" }
