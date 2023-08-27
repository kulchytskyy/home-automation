#!/bin/bash

DEVICE="/dev/ttyUSB0"
BMS_CLI="daly-bms-cli"

SOC_OUTPUT=`$BMS_CLI  -d $DEVICE --soc`
#VOLTAGE=`echo $SOC_OUTPUT | jq ".total_voltage"`
#CURRENT=`echo $SOC_OUTPUT | jq ".current"`
#SOC=`echo $SOC_OUTPUT | jq ".soc_percent"`

#echo "soc=$SOC_OUTPUT"
#echo "voltage=$VOLTAGE"
#echo "current=$CURRENT"
#echo "soc=$SOC"

case "$1" in

    voltage)
    	v=`echo $SOC_OUTPUT | jq ".total_voltage"`
	if (( $(echo "$v < 100" | bc -l) )) && (( $(echo "$v > 0" | bc -l) )); then
		echo $v
	fi
    ;;

    current)
        echo $SOC_OUTPUT | jq ".current"
    ;;

    soc)
        echo $SOC_OUTPUT | jq ".soc_percent"
    ;;
    
    power)
    	v=`echo $SOC_OUTPUT | jq ".total_voltage"`
    	#echo "v=$v"
	if (( $(echo "$v < 100" | bc -l) )) && (( $(echo "$v > 0" | bc -l) )); then
	    	c=`echo $SOC_OUTPUT | jq ".current"`
    		#echo "c=$c"
	    	if (( $(echo "$c < 100" | bc -l) )) && (( $(echo "$c > -100" | bc -l) )); then
		    	p=`echo "$v*$c" | bc`
    			echo $p
    		fi
	fi
    ;;
    	
    cells_diff)
	o=`$BMS_CLI  -d $DEVICE --all`
	h=`echo $o | jq ".cell_voltage_range.highest_voltage"`
	#echo $h
	l=`echo $o | jq ".cell_voltage_range.lowest_voltage"`
	#echo $l
	d=`echo "($h-$l)*1000" | bc`
	
	if (( $(echo "$d < 1000" | bc -l) )) && (( $(echo "$d > 0" | bc -l) )); then
        	echo $d
	fi
    ;;
    	
esac

