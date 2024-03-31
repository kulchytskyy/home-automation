#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh

URL="http://api.weatherapi.com/v1/current.json?key=$WEATHERAPI_APIKEY&q=$CITY"
#echo $URL

DATA=`wget -q -O- $URL`
#echo $DATA

CLOUDCOVER=`echo $DATA | jq ".current.cloud"`

#echo CLOUDCOVER=$CLOUDCOVER
echo $CLOUDCOVER


