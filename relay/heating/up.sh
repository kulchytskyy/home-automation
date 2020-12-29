#!/bin/bash

DIR=$(dirname "$0")
LOGFILE=/var/log/ha/dhw.log

source $DIR/../config.sh
if [ -f $DIR/config.sh ]; then
	source $DIR/config.sh
fi
source $DIR/pins.sh

echo "`date -u` Switching to water heating" | tee -a $LOGFILE

if [[ `cat /var/ha/boiler/dhw` == "WATER" ]]; then
	echo "Already heating water" | tee -a $LOGFILE
	exit
fi

echo "WATER" > /var/ha/boiler/dhw

bash $DIR/../run.sh $UP_PIN $DOWN_PIN

 