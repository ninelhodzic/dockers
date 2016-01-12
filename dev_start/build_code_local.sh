#!/bin/bash

DATE=`date +%Y-%m-%d-%H-%M-%S`
echo $DATE

DEPLOYMENT_PATH="/opt/docker_data/storm/deployment"
STORM_DEPLOYMENT_JAR="olyfeStorm-0.0.1-SNAPSHOT.jar"
CODE_PATH="/var/javaApps/olyfe"

cd $CODE_PATH
mvn clean
mvn install

sudo cp ./olyfeWS/target/olyfeWS.war /var/lib/tomcat7/webapps/
sudo service tomcat7 restart

cd $CODE_PATH/olyfeStorm
mvn clean
mvn install -P docker

sudo mkdir -p $DEPLOYMENT_PATH/backup
if [ -f $DEPLOYMENT_PATH/$STORM_DEPLOYMENT_JAR ]; then
    sudo mv $DEPLOYMENT_PATH/$STORM_DEPLOYMENT_JAR $DEPLOYMENT_PATH/backup/$DATE-$STORM_DEPLOYMENT_JAR
fi

sudo cp $CODE_PATH/olyfeStorm/target/$STORM_DEPLOYMENT_JAR $DEPLOYMENT_PATH/

# copy sentiment models
sudo mkdir -p $DEPLOYMENT_PATH/sentiment
sudo cp $CODE_PATH/olyfeSocial/*.gz $DEPLOYMENT_PATH/sentiment/

#do we need to kill hbase and storm to restart it and then deploy to storm so Storm is reconnected to Zookeeper?

docker exec docker-storm /bin/bash /storm-deployment.sh