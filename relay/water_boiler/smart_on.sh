#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh

echo "`date` Checking if water boiler can be switched on" | tee -a $LOGFILE

IS_SUNNY=`$DIR/is_sunny.sh`
echo IS_SUNNY=$IS_SUNNY

if [ "$IS_SUNNY" = true ] ; then
	bash $DIR/safe_on.sh
else
	echo "`date` No sun" | tee -a $LOGFILE
fi



