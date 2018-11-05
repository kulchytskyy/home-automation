#!/bin/bash

CHECKED_PIN=$1
echo "double checking pin $CHECKED_PIN"
VALUE=`gpio -g read $CHECKED_PIN`

if [[ $VALUE -eq 0 ]]
then
	echo "!!! Pin $CHECKED_PIN active. Aborting";
	exit 1;
fi
 