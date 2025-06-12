
session='halcyon'
tmux has-session -t $session 2>/dev/null

if [ $? == 0 ]; then
    tmux -2 attach-session -t $session
    exit
fi


tmux start-server
tmux set-option remain-on-exit on
# Create session 'Work' with window 'Dev' running vim
tmux new-session -d -s $session -n 'dev'
# Open vim, such that pane remains open when vim closes
tmux select-pane -T 'vim'

# tmux send-keys "vim --servername tmuxvim" Enter
tmux send-keys "nvim --listen /tmp/nvimsocket" Enter

# Split into 2 panes
tmux split-window -h -p 95
# tmux split-window -v -p 5
# Create other usefull windows
tmux new-window -n 'home'

# Set main window in focus and attach session
tmux select-window -t 1
tmux select-pane -t 2
tmux -2 attach-session -t $session
