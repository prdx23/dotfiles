#!/bin/bash

charge=$(cat /sys/class/power_supply/BAT0/capacity)
is_charging=$(cat /sys/class/power_supply/BAT0/status)
symbol='✖'
if [[ $is_charging != 'Discharging' ]]; then
    symbol=''
fi

if [[ $1 == 'icon' ]]; then
    echo $symbol
else
    echo $charge%
fi

