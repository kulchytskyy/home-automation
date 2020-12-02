#!/bin/bash

DIR=$(dirname "$0")

source $DIR/../config.sh
if [ -f $DIR/config.sh ]; then
	source $DIR/config.sh
fi
source $DIR/pins.sh

echo "`date -u` Switching to house heating" >> /var/log/ha/dhw.log

echo "HOUSE" > /var/ha/boiler/dhw

#bash $DIR/../run.sh $DOWN_PIN $UP_PIN

 