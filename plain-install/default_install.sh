#! /bin/bash

# update apt
apt-get update

# install java
apt-get install -y openjdk-7-jdk

echo "# set JAVA_HOME"  >> ~/.bashrc 
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64" >> ~/.bashrc 
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc

# install maven
apt-get install -y maven

# install git
apt-get install -y git

# install nodejs
apt-get install -y python-software-properties
add-apt-repository ppa:chris-lea/node.js -y
apt-get update
apt-get install -y nodejs

# install node js dependent software
npm install -g nws
npm install -g forever

# install tomcat
apt-get install tomcat7

# install apache and PHP
apt-get install -y software-properties-common LANG=C.UTF-8 add-apt-repository ppa:ondrej/php5-5.6 -y
apt-get update
apt-get install -y apache2 php5 libapache2-mod-php5 php5-gd php5-json php5-curl
a2enmod rewrite

# install Docker
apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
cat > /etc/apt/sources.list.d/docker.list << 'EOF'
# Ubuntu Trusty
deb https://apt.dockerproject.org/repo ubuntu-trusty main
EOF
apt-get update
apt-get install -y docker-engine

#install mysql client to talk with MySql and upload the scripts
apt-get install -y mysql-client-core-5.6
