#!/bin/bash


source $DIR/../config.sh

LAST_TRY_FILE=/var/ha/boiler/water/last_try
DATE_FORMAT="+%Y-%m-%d %H:%M:%S"

#date "$DATE_FORMAT" > $LAST_TRY_FILE

LAST_TRY=`cat $LAST_TRY_FILE`
echo "LAST_TRY=$LAST_TRY"

start_ts=$(date -d "$LAST_TRY" '+%s')
end_ts=$(date '+%s')
date_diff=$(( ( end_ts - start_ts )/(60) ))

echo date_diff=$date_diff



#if (( $CLOUDCOVER < $CLOUDCOVER_MAX )); then
#	echo true
#else
#	echo false
#fi

