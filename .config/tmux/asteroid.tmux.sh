#!/bin/bash

# Colors
bg='#141415'
fg='#c5c8c6'

dark0='#1b1b1c'
dark1='#25262c'
dark2='#2c2e34'
light1='#33353f'
light2='#4f5462'
light3='#7f8490'

darkbg=$dark1
darkfg=$light3

midbg=$light1
midfg=$fg

red='#fc5d7c'
orange='#f39660'
yellow='#e7c664'
green='#83d28d'
blue='#7dc3bd'
lightblue='#7eb2dd'
cyan='#56eded'
aqua='#00bcbc'
purple='#9c8cc3'



# General settings ------------------------------------------------------------
set -g status-style bg="$bg",fg="$fg"
set -g status on
set -g status-interval 2
# set -g status-interval 30
set -g status-justify "left"
set -g pane-border-style bg="$bg",fg="$light1"
set -g pane-active-border-style bg="$bg",fg="$lightblue"

# Windows dislpay format
set -g window-status-current-format "#[fg=$cyan][#I:#W] "
set -g window-status-format "#[fg=$light2]#I:#W "
# -----------------------------------------------------------------------------



# Statusline: Right -----------------------------------------------------------
battery_icon="#(bash ~/.config/tmux/battery.sh icon)"
battery_charge="#(bash ~/.config/tmux/battery.sh)"
battery="#[fg=$bg,bold]#[bg=$lightblue] $battery_icon $battery_charge"

# Music stats
# music_icon="♫"
# music_sep="-"
# artist="#(. ~/.config/tmux/spotify.sh artist)"
# album="#(. ~/.config/tmux/spotify.sh album)"
# song="#(. ~/.config/tmux/spotify.sh song)"
# music="#[fg=$red]$music_icon $song #[fg=$light2]$music_sep #[fg=$orange]$artist"
music="#(python3 ~/.config/tmux/spotify.py '#[fg=$red]♫ [song] #[fg=$light2]by #[fg=$orange][artist]')"

date="#[fg=$darkfg]#[bg=$darkbg] %a %b %d"
clock="#[fg=$fg,bold]#[bg=$darkbg]%H:%M"

right="$music $date | $clock $battery "
# right="$date | $clock $battery "
set -g status-right-length 200
set -g status-right $right
# -----------------------------------------------------------------------------



# Statusline: Left ------------------------------------------------------------
ip="#(ip route get 1 | cut -d ' ' -f 7)"
# uptime="#(bash ~/.config/tmux/uptime.sh)"
uptime=""
section="#[fg=$green,none]#[bg=$darkbg] $ip #[fg=$darkfg]| ﰵ $uptime"
left="#[fg=$bg,bold]#[bg=$lightblue] #S $section#[fg=$light2,none]#[bg=$bg]  "
set -g status-left-length 120
set -g status-left $left
# -----------------------------------------------------------------------------



