#!/bin/bash

seconds=$(cut -d' ' -f1 < /proc/uptime)
seconds=${seconds%.*}
echo $seconds
d=$(( seconds / 86400 ))
h=$(( (seconds / 3600) % 24 ))
m=$(( (seconds / 60) % 60 ))
s=$(( seconds % 60 ))
echo $d'd '$h'h '$m'm '
# echo $d'd '$h'h '$m'm '$s's '
