#!/bin/bash

echo "============================="
echo " starting Tomcat7"
echo "============================="


service tomcat7 restart

# infinite loop
while :; do echo "Running Tomcat ..."; sleep 5; done