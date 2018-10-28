#!/bin/bash

source upload/config.sh

API_KEY="47AQH7TEOTQPFNJY"

URL_PARAMS=""
FIELD_NUM=1

###
### w1
###
#TEMP1=$(./temperature/w1/get.sh "28-0416812d86ff")
#echo "TEMP1=$TEMP1"
#if [ ! -z $TEMP1 ]; then
#   URL_PARAMS="$URL_PARAMS&field1=$TEMP1"
#fi

#TEMP2=$(./temperature/w1/get.sh "28-0416816c14ff")
#echo "TEMP2=$TEMP2"
#if [ ! -z $TEMP2 ]; then
#   URL_PARAMS="$URL_PARAMS&field2=$TEMP2"
#fi

TEMP3=$(./temperature/w1/get.sh "28-03168123a0ff")
echo "TEMP3=$TEMP3"
if [ ! -z $TEMP3 ]; then
   URL_PARAMS="$URL_PARAMS&field3=$TEMP3"
fi

TEMP4=$(./temperature/w1/get.sh "28-0316811ffaff")
echo "TEMP4=$TEMP4"
if [ ! -z $TEMP4 ]; then
   URL_PARAMS="$URL_PARAMS&field4=$TEMP4"
fi

TEMP5=$(./temperature/w1/get.sh "28-0416810106ff")
echo "TEMP5=$TEMP5"
if [ ! -z $TEMP5 ]; then
   URL_PARAMS="$URL_PARAMS&field5=$TEMP5"
fi

TEMP6=$(./temperature/w1/get.sh "28-0416812edaff")
echo "TEMP6=$TEMP5"
if [ ! -z $TEMP6 ]; then
  URL_PARAMS="$URL_PARAMS&field6=$TEMP6"
fi

TEMP7=$(./temperature/w1/get.sh "28-0516848757ff")
echo "TEMP7=$TEMP7"
if [ ! -z $TEMP7 ]; then
  URL_PARAMS="$URL_PARAMS&field7=$TEMP7"
fi


###
### send
###
echo $(date)
echo "url_params=$URL_PARAMS"
wget -qO- "$API_URL?api_key=$API_KEY&$URL_PARAMS"
