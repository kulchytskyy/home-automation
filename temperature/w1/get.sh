#!/bin/bash

DEVICE_ID=$1
#echo $1

TEMP_RAW=$(cat "/sys/bus/w1/devices/$DEVICE_ID/w1_slave")
#echo "raw=$TEMP_RAW"

TEMP_NUMERIC=$(echo "$TEMP_RAW" | grep t= |  cut -f2 -d= | awk '{print $1/1000}')
#echo "numeric=$TEMP_NUMERIC"

echo $TEMP_NUMERIC
