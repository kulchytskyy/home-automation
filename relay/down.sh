#!/bin/bash

DIR=$(dirname "$0")

source $DIR/../config.sh
source $DIR/pins.sh

bash $DIR/../run.sh $DOWN_PIN $UP_PIN

 