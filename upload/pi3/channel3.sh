#!/bin/bash

DIR=$(dirname $0)
source $DIR/../config.sh

API_KEY=$API_KEY2

URL_PARAMS=""
FIELD_NUM=1

echo $(date) 

FLOOR1=$($DIR/../../temperature/w1/get.sh "28-3c01b556458b")
echo "FLOOR1=$FLOOR1"
if [ ! -z $FLOOR1 ]; then
   URL_PARAMS="$URL_PARAMS&field4=$FLOOR1"
fi

FLOOR2=$($DIR/../../temperature/w1/get.sh "28-3c01b55639bf")
echo "FLOOR2=$FLOOR2"
if [ ! -z $FLOOR2 ]; then
   URL_PARAMS="$URL_PARAMS&field5=$FLOOR2"
fi


###
### send
###
echo "url_params=$URL_PARAMS"
wget -nv -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

echo -e "\n\n"
