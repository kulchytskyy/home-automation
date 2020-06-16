#!/bin/bash

echo "scale=20;rh=$1;t=$2;var1=(17.67*t)/(243.5+t);var2=e(l(2.71828)*var1);var3=(6.112*var2*rh*2.1674)/(273.15+t);print var3" | bc -l
