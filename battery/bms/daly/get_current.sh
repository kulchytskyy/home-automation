#!/bin/bash

DIR=$(dirname "$0")

$DIR/get.sh soc | $DIR/parse.sh current


