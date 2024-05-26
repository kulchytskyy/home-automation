#!/bin/bash

BOILER2_CH_MAX_TEMP=78

DIR=$(dirname $0)

echo
echo "`date`"
echo "boiler2"

BOILER2_CH_TEMP=$($DIR/../sensor/get.sh boiler2_ch_temp)
RADIATOR_DISABLED=$(gpio -g read 25)

if [ -z $BOILER2_CH_TEMP ]; then
        echo "Retrieving boilder2 ch temp from emodul"
        BOILER2_CH_TEMP=$($DIR/../sensor/get.sh boiler2_ch_emodul_temp)
fi

echo "BOILER2_CH_TEMP = $BOILER2_CH_TEMP"
echo "RADIATOR_DISABLED = $RADIATOR_DISABLED"

if (( $(echo "$BOILER2_CH_TEMP > $BOILER2_CH_MAX_TEMP" | bc -l) )); then
	echo "Enabling radiator $BOILER2_CH_TEMP > $BOILER2_CH_MAX_TEMP"
	if [[ $RADIATOR_DISABLED -eq 0 ]]; then
		echo "Already enabled";
		exit
	fi	

    	bash $DIR/../relay/radiator/on.sh
       	$DIR/notify/notify.sh "Enabling radiator"
else 
	if [[ $RADIATOR_DISABLED -eq 1 ]]; then
		echo "Already disabled";
		exit
	fi	

    	bash $DIR/../relay/radiator/off.sh
       	$DIR/notify/notify.sh "Disabling radiator"
fi
