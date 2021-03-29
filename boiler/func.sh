#!/bin/bash

DIR=$(dirname $0)
API_URL=https://api.thingspeak.com/
CHANNEL1=206671

function get_from_cloud {
        #echo "get_from_cloud $1 $2"
        OUTPUT=`curl -s "$API_URL/channels/$1/fields/$2.csv?results=5"`
        #echo "out=$OUTPUT"
        LAST_VALUE=`echo "$OUTPUT" | tail -n 1 | cut -d "," -f 3`
        #echo "last=$LAST_VALUE"
        if [ -z "$LAST_VALUE" ]; then
                LAST_VALUE=`echo "$OUTPUT" | tail -n 2 | head -n 1 | cut -d "," -f 3`
                #echo "last=$LAST_VALUE"
        fi
        echo $LAST_VALUE
}

