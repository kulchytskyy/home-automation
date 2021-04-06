#!/bin/bash

DIR=$(dirname $0)

OUTDOOR_MIN=0
BOILER_OUTDOOR_MIN=14
LIVING_ROOM_MIN=21.3
BOILER_CH_MIN=63
BOILER_DHW_MIN=50
BOILER_ACTIVITY_MAX=90

source $DIR/../config.sh
source $DIR/../func.sh

echo ""
echo "`date`"
echo "Sunny day stop check"

OUTDOOR=$(get_from_cloud $CHANNEL1 3);
echo "outdoor=$OUTDOOR"
BOILER_OUTDOOR=$(get_from_cloud $CHANNEL1 5);
echo "boiler-outdoor=$BOILER_OUTDOOR"
LIVING_ROOM=$(get_from_cloud $CHANNEL1 1);
echo "living room=$LIVING_ROOM"
BOILER_CH=$(get_from_cloud $CHANNEL1 4);
echo "boiler ch=$BOILER_CH"
BOILER_DHW=$(get_from_cloud $CHANNEL1 7);
echo "boiler dhw=$BOILER_DHW"
BOILER_ACTIVITY=$(get_from_cloud $CHANNEL1 6);
echo "boiler activity=$BOILER_ACTIVITY"

if 		(( $(echo "$OUTDOOR > $OUTDOOR_MIN" | bc -l) )) \
	&& 	(( $(echo "$BOILER_OUTDOOR > $BOILER_OUTDOOR_MIN" | bc -l) )) \
	&& 	(( $(echo "$LIVING_ROOM > $LIVING_ROOM_MIN" | bc -l) )) \
	&& 	(( $(echo "$BOILER_CH > $BOILER_CH_MIN" | bc -l) )) \
	&& 	(( $(echo "$BOILER_DHW > $BOILER_DHW_MIN" | bc -l) )) \
	&& 	(( $(echo "$BOILER_ACTIVITY < $BOILER_ACTIVITY_MAX" | bc -l) ));
then
	echo "Boiler can be switched off"
	
	STATUS="$($DIR/../../emodul/status.sh)"
	CONTROLLER_STATUS=$(echo "$STATUS" | grep CONTROLLER_STATUS | cut -d "=" -f 2)
	MODULE_STATUS=$(echo "$STATUS" | grep MODULE_STATUS | cut -d "=" -f 2)
	BOILER_STATUS=$(echo "$STATUS" | grep "^STATUS" | cut -d "=" -f 2)

	if [ "$CONTROLLER_STATUS" = '"active"' ] && [ "$MODULE_STATUS" = '"active"' ] && [ "$BOILER_STATUS" = 'pid operation' ]; then
        	echo "Boiler is active. Stopping.."
        	$DIR/../../monitor/notify.sh "" "Switching off boiler because of sunny day"
		$DIR/../stop.sh
	else
		echo "Boiler is not active"
        fi
else
	echo "Continue heating"
fi 
 
