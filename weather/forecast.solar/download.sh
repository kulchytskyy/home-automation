#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh

mkdir -p $VARDIR

DATAFILE="$VARDIR/estimate.json"

#https://api.forecast.solar/estimate/49.75/24.16/37/-60/3.2
URL="https://api.forecast.solar/estimate/$LAT/$LON/$DEC/$AZ/$KWP"

echo $URL >> $LOGFILE

DATA=`wget -q -O- $URL`
echo $DATA > $DATAFILE
echo $DATA >> $LOGFILE



