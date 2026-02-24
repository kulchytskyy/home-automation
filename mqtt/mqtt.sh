#!/bin/bash

DIR=$(dirname "$0")

source ~/.ha_creds
source $DIR/config.sh
mosquitto_pub -h $MQTT_BROKER -u $MQTT_USER -P $MQTT_PASSWORD -t "$1" -m "$2"
