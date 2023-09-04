#!/bin/bash

LAST_TRY_FILE=/var/ha/boiler/water/last_try
DATE_FORMAT="+%Y-%m-%d %H:%M:%S"
LOGFILE=/var/log/ha/water_boiler.log

export LAST_TRY_FILE DATE_FORMAT LOGFILE
