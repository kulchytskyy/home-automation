#!/bin/bash

DIR=$(dirname $0)
source $DIR/config.sh

API_KEY=$API_KEY3

URL_PARAMS=""

echo $(date) 

###
### w1
###
TEMP1=$($DIR/../temperature/w1/get.sh "28-0000052d025e")
echo "TEMP1=$TEMP1"
if [ ! -z $TEMP1 ]; then
   URL_PARAMS="$URL_PARAMS&field1=$TEMP1"
fi

###
### send
###
echo "url_params=$URL_PARAMS"
wget -qO- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

echo -e "\n\n"
