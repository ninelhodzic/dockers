#!/bin/bash

echo "============================="
echo " install jdk7"
echo "============================="

apt-get update;
apt-get install -y openjdk-7-jdk

echo "# set JAVA_HOME"  >> ~/.bashrc 
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64" >> ~/.bashrc 
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc

#ENV JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64

java -version 