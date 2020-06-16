#!/bin/bash

DIR=$(dirname $0)
source $DIR/../config.sh

API_KEY=$API_KEY4

URL_PARAMS=""

echo $(date) 

H2=$($DIR/../../temperature/ea2/get_hum.sh 42)
echo "H2=$H2"
if [ ! -z $H2 ]; then
  URL_PARAMS="$URL_PARAMS&field2=$H2"
  
  ABS_H2=$($DIR/../../humidity/abshum.sh $H2 22)
  echo "abs hum2= $ABS_H2"
fi



###
### send
###
echo "url_params=$URL_PARAMS"
wget -nv -O- "${API_URL}?api_key=${API_KEY}${URL_PARAMS}"

echo -e "\n\n"
