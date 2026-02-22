#!/bin/bash

source ~/.ha_creds
source config.sh
mosquitto_pub -h $MQTT_BROKER -u $MQTT_USER -P $MQTT_PASSWORD -t "$1" -m "$2"
