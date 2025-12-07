#!/bin/bash

DIR=$(dirname "$0")


sleep_hour_start=0
sleep_hour_end=6

current_hour=$(date +%H)
echo $current_hour

if [ $current_hour -ge $sleep_hour_start ] && [ $current_hour -lt $sleep_hour_end ]; then
	echo "Sleep hour ($current_hour within $sleep_hour_start and $sleep_hour_end)"	
	$DIR/telegram/info.sh "!!! $1"
else
	$DIR/telegram/alert.sh "!!! $1"
fi



