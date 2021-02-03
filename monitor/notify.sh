#!/bin/bash

HISTORY=/var/ha/notify/history

DIR=$(dirname $0)

type=$1
message=$2

LAST_LINE=`grep  "|$type|" $HISTORY | tail -n 1`
#echo $LAST_LINE

DATE_STR=`echo $LAST_LINE | cut -d "|" -f 1`
#echo $DATE_STR

DATE=$(date -d "$DATE_STR" +%s)
#echo $DATE

AGO_DATE=$(date --date='1 hours ago' +%s)
#echo $AGO_DATE

if [ $DATE -ge $AGO_DATE ]; then
	echo "already sent"
else
	echo "not sent"
	
	echo "`date`|$type|$message" >> $HISTORY

	notify --text "$message"
fi

