#!/bin/bash

DIR=$(dirname "$0")

source $DIR/pins.sh

echo "reading $PIN"
VALUE=`gpio -g read $PIN $1`

echo "value=$VALUE"

if [ $VALUE == 1 ]; then
	echo "No AC voltage detected"
else	
	echo "AC is on"
fi
	