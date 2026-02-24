#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh
source $DIR/pins.sh

echo "`date` Enabling water boiler" | tee -a $LOGFILE
date "$DATE_FORMAT" > $LAST_TRY_FILE

bash $DIR/../mode.sh
bash $DIR/../write.sh 1

$DIR/../../notify/notify.sh "Switched on water boiler" 

state=$($DIR/../../mqtt/pin_state.sh $PIN $ENABLED_VALUE)
$($DIR/../../mqtt/mqtt.sh "$TOPIC/state" $state)

