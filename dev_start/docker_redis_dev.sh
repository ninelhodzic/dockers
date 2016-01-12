#!/bin/bash

PARENT_DIRECTORY="$(dirname "$(pwd)")"
#SOURCE_CODE_DIRECTORY=/home/ninel
CURRENT_DIRECTORY="$(pwd)"
# docker puller and start

# check if folder for docker and services data exists
DATA_DIRECTORY=/opt/docker_data
REDIS_DATA_DIRECTORY="$DATA_DIRECTORY"/redis


HOST_MACHINE_HOSTNAME=$(hostname)
HOST_MACHINE_IP=$(ip route | awk '/docker/ { print $NF }')

# create folder if not exists
#sudo mkdir -p "$DATA_DIRECTORY"

# run docker images
# start Redis
echo "Creating if not exists: $REDIS_DATA_DIRECTORY and start Docker image"
mkdir -p "$REDIS_DATA_DIRECTORY"
IMAGE_EXISTS=$(docker ps -a | grep "docker-redis")
echo "docker-redis exists: $IMAGE_EXISTS"
if [ ! "$IMAGE_EXISTS" ]; then
		#docker pull redis:3.0.5
		docker run --name docker-redis -p 6379:6379 -v "$REDIS_DATA_DIRECTORY":/data -d redis:3.0.5
	else
		echo "starting docker-redis"
		docker start docker-redis &> /dev/null
fi
