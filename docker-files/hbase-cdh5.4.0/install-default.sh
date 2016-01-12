#!/bin/bash 

echo "============================="
echo " install default utils"
echo "============================="

#yum install clean all
#yum install -y curl wget sudo telnet

apt-get update
apt-get install -y curl wget sudo telnet nano