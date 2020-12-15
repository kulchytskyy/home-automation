#!/bin/bash

pin=$1
MULTIPLEXER_PINS=( 21 20 16 12 )

if (($pin < 0 || $pin > 15)); then
	echo "pin parameter should be in range 0-15, but it is $pin"
	exit 1
fi

bin=`echo "obase=2;$pin" | bc`
#echo $bin

bin_len=${#bin}
#echo "len=$bin_len"

append=$((4-$bin_len))
#echo "append=$append"

if (( $append > 0 )); then
	for j in {1..$(seq 1 $append)}; do
		bin="0$bin"
	done
fi
#echo "bin=$bin"

for i in {1..4}; do
	active=`echo "$bin" | cut "-c$i-$i"`
	if [ -z $active ]; then 
		active=0
	fi
	multiplexer_pin=${MULTIPLEXER_PINS[$i-1]}
	echo "multiplexer_pin=$multiplexer_pin active=$active"
	
	gpio -g mode $multiplexer_pin out
	gpio -g write $multiplexer_pin $active
done



