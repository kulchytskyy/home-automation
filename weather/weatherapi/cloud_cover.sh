#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh

URL="http://api.weatherapi.com/v1/current.json?key=$WEATHERAPI_APIKEY&q=$CITY"
echo $URL >> $LOGFILE

DATA=`wget -q -O- $URL`
echo $DATA >> $LOGFILE

CLOUDCOVER=`echo $DATA | jq ".current.cloud"`

echo CLOUDCOVER=$CLOUDCOVER >> $LOGFILE
echo $CLOUDCOVER


