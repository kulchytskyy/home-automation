#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh

QUERY_FIELDS="battery_voltage|battery_power|battery_current|percent_remain|delta_cell_voltage"

jkbms -p $BLUETOOTH_ADDRESS -P $PROTOCOL -c getCellData --filter $QUERY_FIELDS  -o simple > $DATA_FILE

