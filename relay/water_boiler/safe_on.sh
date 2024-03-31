#!/bin/bash

SLEEP_SECONDS=15
BMS_MIN_POWER=-300

DIR=$(dirname "$0")

source $DIR/config.sh
source $DIR/pins.sh

BOILER_ON=$(gpio -g read $PIN)
if [[ $BOILER_ON -eq 1 ]]; then
	echo "`date` Boiler is already on" | tee -a $LOGFILE
	exit 0;
fi

echo "`date` Trying to switch water boiler on" | tee -a $LOGFILE

bash $DIR/on.sh

echo "Waiting $SLEEP_SECONDS seconds to check power consumption"
sleep $SLEEP_SECONDS

BMS_POWER=$("$DIR/../../battery/bms/daly/get.sh" power)

echo "BMS_POWER = $BMS_POWER" 

if (( $(echo "$BMS_POWER < $BMS_MIN_POWER" | bc -l) )); then
        echo "`date` Disabling water boiler $BMS_POWER < $BMS_MIN_POWER" | tee -a $LOGFILE
        bash $DIR/off.sh
fi
