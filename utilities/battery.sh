#!/bin/bash

BOLT=''
CROSS='✖'

charge=$(cat /sys/class/power_supply/BAT0/capacity)
is_charging=$(cat /sys/class/power_supply/BAT0/status)

color=''
if [ $charge -gt 70 ]; then
    color='#[fg=green,bold]'
elif [ $charge -gt 35 ]; then
    color='#[fg=yellow,bold]'
else
    color='#[fg=red,bold]'
fi

if [ $is_charging = "Discharging" ]; then
    #symbol=' #[fg=red]'$CROSS
    symbol=' '$CROSS
else
    #symbol=' #[fg=green,bold]'$BOLT
    symbol=' '$BOLT
fi

#echo $color$charge%$symbol
echo $charge%$symbol

