#!/bin/bash

DIR=$(dirname $0)
source $DIR/../config.sh

API_KEY=$API_KEY3

URL_PARAMS=""

echo $(date) 


FLOOR1=$($DIR/../../sensor/get.sh floor1)
echo "FLOOR1=$FLOOR1"
if [ ! -z $FLOOR1 ]; then
   URL_PARAMS="$URL_PARAMS&field4=$FLOOR1"
fi

FLOOR2=$($DIR/../../sensor/get.sh floor2)
echo "FLOOR2=$FLOOR2"
if [ ! -z $FLOOR2 ]; then
   URL_PARAMS="$URL_PARAMS&field5=$FLOOR2"
fi


### send
echo "url_params=$URL_PARAMS"
wget -nv -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

echo -e "\n\n"
