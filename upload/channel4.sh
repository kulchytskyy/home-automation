#!/bin/bash

DIR=$(dirname $0)
source $DIR/config.sh

API_KEY=$API_KEY4

URL_PARAMS=""

echo $(date) 

###
### bme280
###
H1=$($DIR/../humidity/bme280/get.py)
echo "H1=$H1"
if [ ! -z $H1 ]; then
   URL_PARAMS="$URL_PARAMS&field1=$H1"
fi

###
### send
###
echo "url_params=$URL_PARAMS"
wget -nv -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

echo -e "\n\n"
