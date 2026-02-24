#!/bin/bash

DIR=$(dirname "$0")
LOGFILE=/var/log/ha/radiator.log

source $DIR/pins.sh

echo "`date -u` Enabling radiator" | tee -a $LOGFILE

bash $DIR/../mode.sh
bash $DIR/../write.sh 1

state=$($DIR/../../mqtt/pin_state.sh $PIN $ENABLED_VALUE)
$($DIR/../../mqtt/mqtt.sh "$TOPIC/state" $state)
 
