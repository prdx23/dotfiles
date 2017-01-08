tmux set-option remain-on-exit on
# Create session 'Work' with window 'Dev' running vim
tmux new-session -d -s 'Work' -n 'Dev' 'vim'
# Split into 2 panes in 55:45 ratio
tmux split-window -h -p 45
# Create other usefull windows
tmux new-window -n 'Home' 
tmux new-window -n 'Python' 'python3'
# Set main window in focus and attach session
tmux select-window -t 1
tmux -2 attach-session -t 'Work'
