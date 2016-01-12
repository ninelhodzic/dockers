#!/bin/bash

echo "============================="
echo " starting Storm nimbus and supervisor"
echo "============================="

STORM_HOME="/opt/storm"

cp storm.yaml /opt/storm/conf/storm.yaml

service monit restart

# infinite loop
while :; do echo "Running Storm ..."; sleep 5; done