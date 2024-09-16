#!/bin/bash

echo "setting $PIN to $1"
#gpio -g write $PIN $1

if (( $1==1 )); then
	v="dh"
else
	v="dl"
fi

#echo $v

raspi-gpio set $PIN op $v
 