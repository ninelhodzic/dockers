#!/bin/bash

PARENT_DIRECTORY="$(dirname "$(pwd)")"
#SOURCE_CODE_DIRECTORY=/home/ninel
CURRENT_DIRECTORY="$(pwd)"
# docker puller and start

# check if folder for docker and services data exists
DATA_DIRECTORY=/opt/docker_data
MONGO_DATA_DIRECTORY="$DATA_DIRECTORY"/mongo


HOST_MACHINE_HOSTNAME=$(hostname)
HOST_MACHINE_IP=$(ip route | awk '/docker/ { print $NF }')

# create folder if not exists
#sudo mkdir -p "$DATA_DIRECTORY"


# run docker images

echo "Creating if not exists: $MONGO_DATA_DIRECTORY and start Docker image"
mkdir -p "$MONGO_DATA_DIRECTORY"
IMAGE_EXISTS=$(docker ps -a | grep "docker-mongo")
echo "docker-mongo exists: $IMAGE_EXISTS"
if [ ! "$IMAGE_EXISTS" ]; then
		echo "pulling mongo"
        docker pull mongo:3
        #docker run --name some-mongo -v /my/own/datadir:/data/db -d mongo:tag
		docker run --privileged=true --name docker-mongo  -p 27017:27017 -v "$MONGO_DATA_DIRECTORY":/data/db -d mongo:3
	else
		echo "starting docker-mongo"
		docker start docker-mongo &> /dev/null
fi