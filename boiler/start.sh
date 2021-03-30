#!/bin/bash

DIR=$(dirname $0)
source $DIR/config.sh

echo "`date`"
echo "Starting boiler"
$DIR/emodul/start.sh
