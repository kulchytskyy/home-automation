#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh

URL="https://api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LON&appid=$OPENWEATHER_APIKEY"
echo $URL >> $LOGFILE

DATA=`wget -q -O- $URL`
echo $DATA >> $LOGFILE

CLOUDCOVER=`echo $DATA | jq ".clouds.all"`

echo CLOUDCOVER=$CLOUDCOVER >> $LOGFILE
echo $CLOUDCOVER


