#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh

PROVIDERS="openweather weatherstack weatherapi"
#PROVIDERS="weatherapi weatherstack"

for provider in $PROVIDERS
do 
	cloudcover=`$DIR/$provider/cloud_cover.sh`
	echo "`date` Cloud cover $provider: $cloudcover" >> $LOGFILE
	re='^[0-9]+$'
	if [[ $cloudcover =~ $re ]] ; then
		echo $cloudcover;
		exit 0;
	fi
done	

exit 1;

