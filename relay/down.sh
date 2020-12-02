#!/bin/bash

DIR=$(dirname "$0")
LOGFILE=/var/log/ha/dhw.log

source $DIR/../config.sh
if [ -f $DIR/config.sh ]; then
	source $DIR/config.sh
fi
source $DIR/pins.sh

echo "`date -u` Switching to house heating" | tee $LOGFILE

if [[ `cat /var/ha/boiler/dhw` == "HOUSE" ]]; then
        echo "Already heating house" | tee $LOGFILE
        exit
fi


echo "HOUSE" > /var/ha/boiler/dhw

bash $DIR/../run.sh $DOWN_PIN $UP_PIN

 