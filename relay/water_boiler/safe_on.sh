#!/bin/bash

SLEEP_SECONDS=10
BMS_MIN_POWER=-200

DIR=$(dirname "$0")
source $DIR/config.sh

echo "`date -u` Trying to switch water boiler on" | tee -a $LOGFILE

bash $DIR/on.sh

echo "Waiting $SLEEP_SECONDS seconds to check power consumption"
sleep $SLEEP_SECONDS

BMS_POWER=$("$DIR/../../battery/bms/daly/get.sh" power)

echo "BMS_POWER = $BMS_POWER" 

if (( $(echo "$BMS_POWER < $BMS_MIN_POWER" | bc -l) )); then
        echo "`date -u` Disabling water boiler $BMS_POWER < $BMS_MIN_POWER" | tee -a $LOGFILE
        bash $DIR/off.sh
fi
