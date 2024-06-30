#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh

PROVIDERS="forecast.solar"

for provider in $PROVIDERS
do 
	solarpower=`$DIR/$provider/solarpower.sh`
	echo "`date` Solar power $provider: $solarpower" >> $LOGFILE
	re='^[0-9]+$'
	if [[ $solarpower =~ $re ]] ; then
		echo $solarpower;
		exit 0;
	fi
done	

exit 1;

