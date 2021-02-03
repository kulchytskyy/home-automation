#!/bin/bash

DIR=$(dirname $0)
source $DIR/config.sh

echo "`date`"
echo "Stopping boiler"
exec $DIR/emodul/stop.sh
 
