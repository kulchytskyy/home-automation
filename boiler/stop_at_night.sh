#!/bin/bash

DIR=$(dirname $0)

OUTDOOR_MIN_TEMP=-2
INDOOR_MIN_TEMP=20

source $DIR/config.sh

echo ""
echo "`date`"
echo "stop at night"

OUTDOOR=`curl -s "https://api.thingspeak.com/channels/206671/fields/3.csv?minutes=30&mp;results=1" | tail -n 1 | cut -d "," -f 3`
INDOOR=`curl -s "https://api.thingspeak.com/channels/206671/fields/1.csv?minutes=30&mp;results=1" | tail -n 1 | cut -d "," -f 3`

echo "outdoor temparature=$OUTDOOR, indoor temperature=$INDOOR"

if (( $(echo "$OUTDOOR > $OUTDOOR_MIN_TEMP" | bc -l) )) && (( $(echo "$INDOOR > $INDOOR_MIN_TEMP" | bc -l) )); then
	echo "switching off boiler"
	exec $DIR/emodul/stop.sh
else
	echo "continue heating"
fi 
 
