#!/bin/bash

DIR=$(dirname "$0")

source $DIR/../config.sh
source $DIR/pins.sh

bash $DIR/../run.sh $UP_PIN $DOWN_PIN

 