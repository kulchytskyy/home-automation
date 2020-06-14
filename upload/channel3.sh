#!/bin/bash

DIR=$(dirname $0)
source $DIR/config.sh

API_KEY=$API_KEY3

URL_PARAMS=""

echo $(date) 

###
### w1
###
TEMP1=$($DIR/../temperature/w1/get.sh "28-0316819430ff")
echo "TEMP1=$TEMP1"
if [ ! -z $TEMP1 ]; then
   URL_PARAMS="$URL_PARAMS&field1=$TEMP1"
fi

TEMP2=$($DIR/../temperature/w1/get.sh "28-0000052cf9c6")
echo "TEMP2=$TEMP2"
if [ ! -z $TEMP2 ]; then
   URL_PARAMS="$URL_PARAMS&field2=$TEMP2"
fi

TEMP3=$($DIR/../temperature/w1/get.sh "28-0416816c14ff")
echo "TEMP3=$TEMP3"
if [ ! -z $TEMP3 ]; then
   URL_PARAMS="$URL_PARAMS&field3=$TEMP3"
fi

###
### send
###
echo "url_params=$URL_PARAMS"
wget -nv -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

echo -e "\n\n"
