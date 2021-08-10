#!/bin/bash

# Colors
bg='#181819'
fg='#e6e6dc'

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
green='#9ed072'
blue='#7dc3bd'
lightblue='#7eb2dd'
cyan='#56ffff'
aqua='#00bcbc'
purple='#9c8cc3'



# General settings ------------------------------------------------------------
set -g status-style bg="$bg",fg="$fg"
set -g status on
set -g status-interval 2
set -g status-justify "left"
set -g pane-border-style bg="$bg",fg="$light1"
set -g pane-active-border-style bg="$bg",fg="$aqua"

# Windows dislpay format
set -g window-status-current-format "#[fg=$cyan][#I:#W] "
set -g window-status-format "#[fg=$light2]#I:#W "
# -----------------------------------------------------------------------------



# Statusline: Right -----------------------------------------------------------
battery_icon="#(bash ~/utilities/battery.sh icon)"
battery_charge="#(bash ~/utilities/battery.sh)"
battery="#[fg=$bg,bold]#[bg=$lightblue] $battery_icon$battery_charge"

# Music stats
music_icon="#(bash ~/utilities/spotify.sh icon)"
music_sep="#(bash ~/utilities/spotify.sh sep)"
artist="#(bash ~/utilities/spotify.sh artist)"
album="#(bash ~/utilities/spotify.sh album)"
song="#(bash ~/utilities/spotify.sh song)"
music="#[fg=$red]$music_icon $song #[fg=$light2]$music_sep #[fg=$orange]$artist"

date="#[fg=$darkfg]#[bg=$darkbg] %a %b %d"
clock="#[fg=$fg,bold]#[bg=$darkbg]%H:%M"

right="$music $date | $clock $battery "
set -g status-right-length 200
set -g status-right $right
# -----------------------------------------------------------------------------



# Statusline: Left ------------------------------------------------------------
ip="#(ip route get 1 | cut -d ' ' -f 7)"
uptime="#(bash ~/utilities/uptime.sh)"
section="#[fg=$yellow,none]#[bg=$darkbg] $ip #[fg=$darkfg]| ﰵ $uptime"
left="#[fg=$bg,bold]#[bg=$lightblue] #S $section#[fg=$light2,none]#[bg=$bg]  "
set -g status-left-length 120
set -g status-left $left
# -----------------------------------------------------------------------------



