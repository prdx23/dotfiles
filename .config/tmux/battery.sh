#!/bin/bash

charge=$(cat /sys/class/power_supply/BAT0/capacity)
is_charging=$(cat /sys/class/power_supply/BAT0/status)


battery_empty=''
battery_low=''
battery_medium=''
battery_high=''
battery_full=''
charging_symbol=''


if (( charge <= 10 )); then
    symbol=$battery_empty
elif (( charge <= 25 )); then
    symbol=$battery_low
elif (( charge <= 50 )); then
    symbol=$battery_medium
elif (( charge <= 75 )); then
    symbol=$battery_high
else
    symbol=$battery_full
fi


if [[ $is_charging != 'Discharging' ]]; then
    symbol="$charging_symbol $symbol"
fi


if [[ $1 == 'icon' ]]; then
    echo $symbol
else
    echo $charge%
fi

