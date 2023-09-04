#!/bin/bash

DIR=$(dirname "$0")

source $DIR/config.sh
source $DIR/pins.sh

echo "`date -u` Disabling water boiler" | tee -a $LOGFILE

bash $DIR/../mode.sh
bash $DIR/../write.sh 0


 