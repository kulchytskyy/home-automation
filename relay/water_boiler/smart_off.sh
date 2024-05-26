#!/bin/bash

BMS_MIN_CURRENT=-30

DIR=$(dirname $0)
source $DIR/pins.sh
source $DIR/config.sh

#echo "`date` Checking if water boiler should be switched off" | tee -a $LOGFILE

#daly-bms-cli --soc -d /dev/ttyUSB0

#../../battery/bms/daly/get.sh power

BMS_CURRENT=$($DIR/../../battery/bms/daly/get_current.sh)
BOILER_ON=$(gpio -g read $PIN)

echo "`date` BMS_CURRENT = $BMS_CURRENT BOILER_ON = $BOILER_ON" | tee -a $LOGFILE

if [[ $BOILER_ON -eq 1 ]]; then
	if (( $(echo "$BMS_CURRENT < $BMS_MIN_CURRENT" | bc -l) )); then
		echo "`date` Disabling water boiler $BMS_CURRENT < $BMS_MIN_CURRENT" | tee -a $LOGFILE

    		bash $DIR/../../relay/water_boiler/off.sh
	       	#$DIR/../../notify/notify.sh "Disabling water boiler"
    	fi
fi
