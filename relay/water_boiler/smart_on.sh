#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh

echo "`date` Checking weather" | tee -a $LOGFILE

solarpower=`$DIR/../../weather/solarpower.sh`
echo solarpower=$solarpower

if (( $solarpower >= $REQUIRED_SOLAR_POWER )); then
	bash $DIR/safe_on.sh
else
	echo "`date` No sun" | tee -a $LOGFILE
fi



