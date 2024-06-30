#!/bin/bash

BOILER_CH_MAX_TEMP=70.5

DIR=$(dirname $0)

echo
echo "`date`"
echo "boiler1"

BOILER_CH_TEMP=$("$DIR/../sensor/get.sh" boiler_ch_temp)
RADIATOR_DISABLED=$(gpio -g read 25)

echo "BOILER_CH_TEMP = $BOILER_CH_TEMP"
echo "RADIATOR_DISABLED = $RADIATOR_DISABLED"

if (( $(echo "$BOILER_CH_TEMP > $BOILER_CH_MAX_TEMP" | bc -l) )); then
	echo "Enabling radiator $BOILER_CH_TEMP > $BOILER_CH_MAX_TEMP"
	if [[ $RADIATOR_DISABLED -eq 0 ]]; then
		echo "Already enabled";
		exit
	fi	

    	bash $DIR/relay/radiator/on.sh
       	$DIR/notify/notify.sh "Enabling radiator"
else 
	if [[ $RADIATOR_DISABLED -eq 1 ]]; then
		echo "Already disabled";
		exit
	fi	

    	bash $DIR/relay/radiator/off.sh
       	$DIR/notify/notify.sh "Disabling radiator"
fi
