#!/bin/bash

F=/var/local/ea2temp.csv

T1=`grep ,$1, $F | tail -n 1 | cut -d , -f 6`
echo $T1

