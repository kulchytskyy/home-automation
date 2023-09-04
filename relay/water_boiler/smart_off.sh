#!/bin/bash

BMS_MIN_POWER=-200

DIR=$(dirname $0)
source $DIR/pins.sh
source $DIR/config.sh

echo "`date -u` Checking if water boiler should be switched off" | tee -a $LOGFILE

#daly-bms-cli --soc -d /dev/ttyUSB0

#../../battery/bms/daly/get.sh power

BMS_POWER=$("$DIR/../../battery/bms/daly/get.sh" power)
BOILER_ON=$(gpio -g read $PIN)

echo "`date -u` BMS_POWER = $BMS_POWER BOILER_ON = $BOILER_ON" | tee -a $LOGFILE

if [[ $BOILER_ON -eq 1 ]]; then
	if (( $(echo "$BMS_POWER < $BMS_MIN_POWER" | bc -l) )); then
		echo "`date -u` Disabling water boiler $BMS_POWER < $BMS_MIN_POWER" | tee -a $LOGFILE

	       	notify --text "Disabling water boiler"
    		bash $DIR/../../relay/water_boiler/off.sh
    	fi
fi
