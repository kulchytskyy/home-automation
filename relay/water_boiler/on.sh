#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh
source $DIR/pins.sh

echo "`date -u` Enabling water boiler" | tee -a $LOGFILE
date "$DATE_FORMAT" > $LAST_TRY_FILE

bash $DIR/../mode.sh
bash $DIR/../write.sh 1


 