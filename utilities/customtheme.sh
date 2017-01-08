
# Define Powerline symbols
left_bold=""
left_thin=""
right_bold=""
right_thin=""
music_icon="♫"

# Define colors to be used
dark_grey_bg=colour236
accent_color=colour63
accent_highlight=colour233
date_color=colour246
time_color=colour255
music_color=colour203
default_bg=colour234

# Default background and foreground
set -g status-bg "$default_bg"
set -g status-fg white

# General settings
set-option -g status on
set-option -g status-interval 2
set-option -g status-justify "left"
set -g pane-border-bg colour234
set -g pane-border-fg colour238
set -g pane-active-border-bg colour234
set -g pane-active-border-fg colour51

# Get generated battery string
battery="#(sh ~/utilities/battery.sh)"
# Get Current playing song's title and artist
player="#(sh ~/utilities/spotify.sh)"

# Create Right part of statusline ------------------
music_s="#[fg=$music_color]$music_icon $player #[fg=$dark_grey_bg]$left_bold"
date_s="#[fg=$date_color,none]#[bg=$dark_grey_bg] %a %d %b $left_thin"
clock_s="#[fg=$time_color,bold] %H:%M "
battery_s="#[fg=$accent_color,bold]$left_bold#[bg=$accent_color]#[fg=$accent_highlight,bold] $battery "

set-option -g status-right-length 120
set-option -g status-right "$music_s$date_s$clock_s$battery_s"

# Create left part of statusline ------------------
session_s="#[bg=$accent_color] #S #[fg=$accent_color]#[bg=$default_bg]$right_bold"
set-option -g status-left-length 30
set-option -g status-left "#[fg=$accent_highlight,bold]$session_s  "

# Create mid part of statusline ------------------
setw -g window-status-current-format "#[fg=colour43,bold][#I:#W] "
setw -g window-status-format "#[fg=colour30]#I:#W "

