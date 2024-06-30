#!/bin/bash

SLEEP_SECONDS=15
BMS_MIN_CURRENT=-30

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

BMS_CURRENT=$("$DIR/../../battery/bms/daly/get_current.sh")

echo "BMS_CURRENT = $BMS_CURRENT" 

if (( $(echo "$BMS_CURRENT < $BMS_MIN_CURRENT" | bc -l) )); then
        echo "`date` Disabling water boiler $BMS_CURRENT < $BMS_MIN_CURRENT" | tee -a $LOGFILE
        bash $DIR/off.sh
fi
