#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh

echo "`date` Checking weather" | tee -a $LOGFILE

IS_SUNNY=`$DIR/../../weather/is_sunny.sh`
echo IS_SUNNY=$IS_SUNNY

if [ "$IS_SUNNY" = true ] ; then
	bash $DIR/safe_on.sh
else
	echo "`date` No sun" | tee -a $LOGFILE
fi



