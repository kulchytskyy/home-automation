#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh

echo "`date` Checking weather" | tee -a $LOGFILE

solarpower=`$DIR/../../weather/solarpower.sh`
echo solarpower=$solarpower

is_sunny=`$DIR/../../weather/is_sunny.sh`
echo is_sunny=$is_sunny

if [ "$is_sunny" = true ] && (( $solarpower >= $REQUIRED_SOLAR_POWER )); then
	bash $DIR/safe_on.sh
else
	echo "`date` No sun" | tee -a $LOGFILE
fi



