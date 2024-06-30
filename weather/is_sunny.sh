#!/bin/bash

CLOUDCOVER_MAX=60

DIR=$(dirname "$0")
source $DIR/config.sh

cloudcover=`$DIR/cloud_cover.sh`

if (( $cloudcover < $CLOUDCOVER_MAX )); then
	echo true
else
	echo false
fi

