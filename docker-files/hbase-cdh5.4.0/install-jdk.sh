#!/bin/bash

echo "============================="
echo " install jdk7"
echo "============================="

#wget --no-cookies \
#	--no-check-certificate \
#	--header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
#	http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64-rpm.bin \
#	--no-check-certificate \
#	-O ./jdk-6u45-linux-x64-rpm.bin

#chmod +x jdk-6u45-linux-x64-rpm.bin
#./jdk-6u45-linux-x64-rpm.bin
#rm jdk-6u45-linux-x64-rpm.bin
#rm sun*.rpm
#rm jdk*.rpm

apt-get update;
apt-get install -y openjdk-7-jdk

echo "# set JAVA_HOME"  >> ~/.bashrc 
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64" >> ~/.bashrc 
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc



#ENV JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64

java -version 