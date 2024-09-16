#!/bin/bash

PARAM=$1

DIR=$(dirname "$0")
source $DIR/config.sh

case "$1" in

    voltage)
	v=`cat $DATA_FILE | grep battery_voltage | cut -d "=" -f 2`
    ;;

    current)
	v=`cat $DATA_FILE | grep battery_current | cut -d "=" -f 2`
     ;;

    soc)
	v=`cat $DATA_FILE | grep percent_remain | cut -d "=" -f 2`
    ;;
    
    power)
    	c=`cat $DATA_FILE | grep battery_current | cut -d "=" -f 2`
	v=`cat $DATA_FILE | grep battery_power | cut -d "=" -f 2`
	if [[ $c =~ ^- ]]; then
		v=-$v
	fi
    ;;
    	
    cells_diff)
	v=`cat $DATA_FILE | grep delta_cell_voltage | cut -d "=" -f 2`
	v=`echo "$v*1000" | bc`
    ;;
    	
esac

echo $v