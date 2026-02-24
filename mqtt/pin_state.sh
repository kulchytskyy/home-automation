#!/bin/bash

pin=$1
enabled_value=$2
#echo $2

#state=$(cat /sys/class/gpio/gpio$pin/value)
state=$(pinctrl get $pin)
#echo $state

if [[ $state == *"$enabled_value"* ]]; then
    report="on"
else
    report="off"
fi

echo $report

