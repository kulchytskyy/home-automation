#!/bin/bash

DIR=$(dirname "$0")

source $DIR/config.sh
source $DIR/pins.sh

echo "`date` Disabling water boiler" | tee -a $LOGFILE

bash $DIR/../mode.sh
bash $DIR/../write.sh 0

$DIR/../../notify/notify.sh "Switched off water boiler"

state=$($DIR/../../mqtt/pin_state.sh $PIN $ENABLED_VALUE)
$($DIR/../../mqtt/mqtt.sh "$TOPIC/state" $state)
 
