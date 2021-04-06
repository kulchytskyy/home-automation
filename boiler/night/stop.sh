#!/bin/bash

DIR=$(dirname $0)

OUTDOOR_MIN_TEMP=-2
INDOOR_MIN_TEMP=20

source $DIR/../config.sh
source $DIR/../func.sh

echo ""
echo "`date`"
echo "stop at night"

OUTDOOR=$(get_from_cloud $CHANNEL1 3);
INDOOR=$(get_from_cloud $CHANNEL1 1);
#OUTDOOR=`curl -s "https://api.thingspeak.com/channels/206671/fields/3.csv?average=30&mp;results=1" | tail -n 1 | cut -d "," -f 3`
#INDOOR=`curl -s "https://api.thingspeak.com/channels/206671/fields/1.csv?average=30&mp;results=1" | tail -n 1 | cut -d "," -f 3`

echo "outdoor temparature=$OUTDOOR, indoor temperature=$INDOOR"

if (( $(echo "$OUTDOOR > $OUTDOOR_MIN_TEMP" | bc -l) )) && (( $(echo "$INDOOR > $INDOOR_MIN_TEMP" | bc -l) )); then
	echo "switching off boiler"
	$DIR/../stop.sh
else
	echo "continue heating"
fi 
 
