#!/bin/bash

DIR=$(dirname "$0")
LOGFILE=/var/log/ha/water_boiler.log

source $DIR/pins.sh

echo "`date -u` Enabling water boiler" | tee -a $LOGFILE

bash $DIR/../mode.sh
bash $DIR/../write.sh 1


 