#!/bin/bash

DIR=$(dirname "$0")

source $DIR/../config.sh
if [ -f $DIR/config.sh ]; then
	source $DIR/config.sh
fi
source $DIR/pins.sh

echo "`date -u` Switching to water heating" >> /var/log/ha/dhw.log

echo "WATER" > /var/ha/boiler/dhw

#bash $DIR/../run.sh $UP_PIN $DOWN_PIN

 