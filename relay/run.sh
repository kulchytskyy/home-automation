#!/bin/bash

PIN=$1
CHECKED_PIN=$2
echo "using pin $PIN"
export PIN

DIR=$(dirname "$0")

(
  flock -n 9 || { echo "!!! Failed to acquire lock. Aborting"; exit 1; }
  bash $DIR/check.sh $CHECKED_PIN || exit 1; 
  bash $DIR/mode.sh
  bash $DIR/write.sh 0
  bash $DIR/sleep.sh
  bash $DIR/write.sh 1 
) 9>$LOCKFILE

 