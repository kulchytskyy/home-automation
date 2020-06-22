#!/bin/bash

DIR=$(dirname $0)
source $DIR/../config.sh

API_KEY=$API_KEY4

URL_PARAMS=""

echo $(date) 

H2_HUM=$($DIR/../../temperature/ea2/get_hum.sh 42)
H2_TEMP=$($DIR/../../temperature/ea2/get_temp.sh 42)
echo "H2_HUM=$H2_HUM"
if [ ! -z $H2_HUM ]; then
  H2_ABS_HUM=$($DIR/../../humidity/abshum.sh $H2_HUM $H2_TEMP)
  echo "H2_ABS_HUM=$H2_ABS_HUM"

  URL_PARAMS="$URL_PARAMS&field2=$H2_HUM&field6=$H2_ABS_HUM"
  
fi



###
### send
###
echo "url_params=$URL_PARAMS"
wget -nv -O- "${API_URL}?api_key=${API_KEY}${URL_PARAMS}"

echo -e "\n\n"
