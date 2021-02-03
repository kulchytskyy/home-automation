#!/bin/bash

DIR=$(dirname $0)

source $DIR/func.sh

echo
echo "`date`"

check_in_range dhw 40 67
check_in_range dhw_center 10 45
check_in_range basement_laundry 15 25
check_in_range basement_large 15 25
check_in_range basement_boiler 15 25
check_gt hum_basement 80

