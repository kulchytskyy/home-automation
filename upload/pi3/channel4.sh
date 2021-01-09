#!/bin/bash

DIR=$(dirname $0)
source $DIR/../config.sh

API_KEY=$API_KEY4

URL_PARAMS=""

echo $(date) 

LIVING_HUM=$($DIR/../../temperature/sdr/get_hum.sh 20)
LIVING_TEMP=$($DIR/../../temperature/sdr/get_temp.sh 20)
echo "LIVING_HUM=$LIVING_HUM"
if [ ! -z $LIVING_HUM ]; then
  LIVING_ABS_HUM=$($DIR/../../humidity/abshum.sh $LIVING_HUM $LIVING_TEMP)
  echo "LIVING_ABS_HUM=$LIVING_ABS_HUM"

  URL_PARAMS="$URL_PARAMS&field2=$LIVING_HUM&field7=$LIVING_ABS_HUM"
  
fi

OUTDOOR_HUM=$($DIR/../../temperature/sdr/get_hum.sh 144)
OUTDOOR_TEMP=$($DIR/../../temperature/sdr/get_temp.sh 144)
echo "OUTDOOR_HUM=$OUTDOOR_HUM"
if [ ! -z $OUTDOOR_HUM ]; then
  OUTDOOR_ABS_HUM=$($DIR/../../humidity/abshum.sh $OUTDOOR_HUM $OUTDOOR_TEMP)
  echo "OUTDOOR_ABS_HUM=$OUTDOOR_ABS_HUM"

  URL_PARAMS="$URL_PARAMS&field3=$OUTDOOR_HUM&field8=$OUTDOOR_ABS_HUM"
  
fi

FLOOR1_DATA=$($DIR/../../humidity/bme280/get.py 77)
echo "FLOOR1_DATA=$FLOOR1_DATA"
if [ ! -z $FLOOR1_DATA ]; then

   FLOOR1_ARR=(${FLOOR1_DATA//|/ })
   FLOOR1_TEMP=${FLOOR1_ARR[0]}
   FLOOR1_HUM=${FLOOR1_ARR[1]}
   echo "FLOOR1_TEMP=$FLOOR1_TEMP FLOOR1_HUM=$FLOOR1_HUM"

   URL_PARAMS="$URL_PARAMS&field4=$FLOOR1_HUM"
fi

FLOOR2_DATA=$($DIR/../../humidity/bme280/get.py 76)
echo "FLOOR2_DATA=$FLOOR2_DATA"
if [ ! -z $FLOOR2_DATA ]; then

   FLOOR2_ARR=(${FLOOR2_DATA//|/ })
   FLOOR2_TEMP=${FLOOR2_ARR[0]}
   FLOOR2_HUM=${FLOOR2_ARR[1]}
   echo "FLOOR2_TEMP=$FLOOR2_TEMP FLOOR2_HUM=$FLOOR2_HUM"

   URL_PARAMS="$URL_PARAMS&field5=$FLOOR2_HUM"
fi


###
### send
###
echo "url_params=$URL_PARAMS"
wget -nv -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

echo -e "\n\n"
