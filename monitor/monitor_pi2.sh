#!/bin/bash

DIR=$(dirname $0)

source $DIR/func.sh

echo
echo "`date`"

#check_in_range dhw 35 67
check_in_range boiler_ch_temp 100 100
#check_in_range dhw_center 10 45
#check_in_range basement_laundry 15 25
#check_in_range basement_large 15 25
#check_in_range basement_boiler 15 25
#check_gt hum_basement 80

