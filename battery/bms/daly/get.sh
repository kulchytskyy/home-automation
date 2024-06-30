#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh

SECTION="${1:-soc}"

#(
#  echo "Obtaining lock"
#  flock -w 2 9 || { echo "!!! Failed to acquire lock. Aborting"; exit 1; }
COMMAND="$BMS_CLI -d $DEVICE --$SECTION"
#echo $COMMAND
DATA=`$COMMAND`
#DATA="{ \"total_voltage\": -26.7, \"current\": 0.0, \"soc_percent\": 195.4 }"
if [ $SECTION = "soc" ]; then
	DATA="{ \"soc\": $DATA }"
fi
echo $DATA | tee $LOGFILE

  
#) 9>$LOCKFILE


