#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh

URL="http://api.weatherstack.com/current?access_key=$WEATHERSTACK_APIKEY&query=$CITY"
#echo $URL

DATA=`wget -q -O- $URL`
#echo $DATA

CLOUDCOVER=`echo $DATA | jq ".current.cloudcover"`

#echo CLOUDCOVER=$CLOUDCOVER
echo $CLOUDCOVER


