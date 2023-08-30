#!/bin/bash

BMS_MIN_POWER=0

DIR=$(dirname $0)
source $DIR/../../relay/water_boiler/pins.sh

echo "`date`"

#daly-bms-cli --soc -d /dev/ttyUSB0

#../../battery/bms/daly/get.sh power


BMS_POWER=$("$DIR/../../battery/bms/daly/get.sh" power)
BOILER_ON=$(gpio -g read $PIN)

echo "BMS_POWER = $BMS_POWER"
echo "BOILER_ON = $BOILER_ON"

if (( $(echo "$BMS_POWER < $BMS_MIN_POWER" | bc -l) )); then
	echo "Disabling water boiler $BMS_POWER < $BMS_MIN_POWER"
	if [[ $BOILER_ON -eq 0 ]]; then
		echo "Already disabled";
		exit
	fi	

       	notify --text "Disabling water boiler"
    	bash $DIR/../../relay/water_boiler/off.sh
else 
	if [[ $BOILER_ON -eq 1 ]]; then
		#echo "Already enabled";
		exit
	fi	

       	#notify --text "Enabling water boiler"
    	#bash $DIR/../../relay/water_boiler/on.sh
fi
