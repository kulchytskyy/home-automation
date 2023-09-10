#!/bin/bash

CLOUDCOVER_MAX=50

DIR=$(dirname "$0")
source $DIR/config.sh
source ~/.ha_creds

CITY="Lviv"
URL="http://api.weatherstack.com/current?access_key=$WEATHERSTACK_APIKEY&query=$CITY"
#echo $URL

DATA=`wget -q -O- $URL`
#echo $DATA

#echo "TEST="
CLOUDCOVER=`echo $DATA | jq ".current.cloudcover"`
echo "`date` Cloud cover $CLOUDCOVER" >> $LOGFILE


#echo CLOUDCOVER=$CLOUDCOVER
#echo $CLOUDCOVER

if (( $CLOUDCOVER < $CLOUDCOVER_MAX )); then
	echo true
else
	echo false
fi

