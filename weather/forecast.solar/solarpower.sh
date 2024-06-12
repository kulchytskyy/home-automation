#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh

DATAFILE="$VARDIR/estimate.json"

curr_date_hour=$(date '+%Y-%m-%d %H:00:00');
echo "curr_date_hour=$curr_date_hour" >> $LOGFILE

solarpower=`jq -e ".result.watts.\"$curr_date_hour\"" < $DATAFILE`
if (( $? != 0 )); then
	echo "No data"
	exit 1
fi

echo "solarpower=$solarpower" >> $LOGFILE

echo $solarpower
