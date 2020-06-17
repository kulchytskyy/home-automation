#!/bin/bash

DIR=$(dirname $0)
source $DIR/../config.sh

API_KEY=$API_KEY4

URL_PARAMS=""

echo $(date) 

###
### bme280
###
H1_DATA=$($DIR/../../humidity/bme280/get.py)
echo "H1_DATA=$H1_DATA"
if [ ! -z $H1_DATA ]; then

   H1_ARR=(${H1_DATA//|/ })
   H1_TEMP=${H1_ARR[0]}
   H1_HUM=${H1_ARR[1]}
   echo "H1_TEMP=$H1_TEMP H1_HUM=$H1_HUM"

   H1_ABS_HUM=$($DIR/../../humidity/abshum.sh $H1_HUM $H1_TEMP)
   echo "H1_ABS_HUM=$H1_ABS_HUM"

   URL_PARAMS="$URL_PARAMS&field1=$H1_TEMP&field5=$H1_ABS_HUM"
fi

###
### send
###
echo "url_params=$URL_PARAMS"
wget -nv -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

echo -e "\n\n"
