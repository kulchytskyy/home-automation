#!/bin/bash

#echo "start"

PARAM=$1

DATA=`cat -`
#echo $DATA

case "$1" in

    voltage)
    	v=`echo $DATA | jq ".soc.total_voltage"`
	if (( $(echo "$v < 100" | bc -l) )) && (( $(echo "$v > 0" | bc -l) )); then
		echo $v
	fi
    ;;

    current)
        v=`echo $DATA | jq ".soc.current"`
        if (( $(echo "$v < 500" | bc -l) )) && (( $(echo "$v > -500" | bc -l) )); then
                echo $v
        fi
     ;;

    soc)
	v=`echo $DATA | jq ".soc.soc_percent"`
	if (( $(echo "$v < 100" | bc -l) )) && (( $(echo "$v > 0" | bc -l) )); then
		echo $v
	fi
    ;;
    
    power)
    	v=`echo $DATA | jq ".soc.total_voltage"`
    	#echo "v=$v"
	if (( $(echo "$v < 100" | bc -l) )) && (( $(echo "$v > 0" | bc -l) )); then
	    	c=`echo $DATA | jq ".soc.current"`
    		#echo "c=$c"
	    	if (( $(echo "$c < 100" | bc -l) )) && (( $(echo "$c > -100" | bc -l) )); then
		    	p=`echo "$v*$c" | bc`
    			echo $p
    		fi
	fi
    ;;
    	
    cells_diff)
	h=`echo $DATA | jq ".cell_voltage_range.highest_voltage"`
	#echo $h
	l=`echo $DATA | jq ".cell_voltage_range.lowest_voltage"`
	#echo $l
	d=`echo "($h-$l)*1000" | bc`
	
	if (( $(echo "$d < 1000" | bc -l) )) && (( $(echo "$d > 0" | bc -l) )); then
        	echo $d
	fi
    ;;
    	
esac

