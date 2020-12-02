#!/bin/bash

DIR=$(dirname $0)

DHW_TARGET_TEMP=60

echo "`date -u`"

if [[ `cat /var/ha/boiler/dhw` != "WATER" ]]; then
	echo "House heating active. Exiting."
	exit
fi


DHW_TEMP_TOP=$($DIR/../temperature/w1/get_abs.sh "28-3c01b556867f")
echo "DHW_TEMP_TOP=$DHW_TEMP_TOP (target=$DHW_TARGET_TEMP)"
DHW_TEMP=$DHW_TEMP_TOP

if [[ ! -z $DHW_TEMP ]] && (( $(echo "$DHW_TEMP > $DHW_TARGET_TEMP" | bc -l) )); then
	echo "Reached target temperature $DHW_TARGET_TEMP. Switching to house heating."
	
	bash $DIR/../relay/heating/house.sh
fi
