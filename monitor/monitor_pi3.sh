#!/bin/bash

DIR=$(dirname $0)

source $DIR/func.sh

echo
echo "`date`"

check_in_range attic 10 30
check_in_range kidroom 17 28
check_in_range bathroom2 13 28
check_in_range bedroom 17 28
check_in_range kidroom2 13 28
check_in_range floor1 13 28
check_in_range floor2 13 28
check_in_range hum_living 30 80
#check_in_range hum_outdoor 10 100
check_in_range hum_floor1 25 80
check_in_range hum_floor2 25 80

check_in_range boiler_ch_temp 15 70
check_in_range boiler_dhw 15 70

check_in_range livingroom 18 26
check_in_range bathroom 16 26
check_in_range outdoor -15 32

