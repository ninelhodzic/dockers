#!/bin/bash

echo "Running base docker installation"
./docker_pull_start_dev.sh

PARENT_DIRECTORY="$(dirname "$(pwd)")"
SOURCE_CODE_DIRECTORY=/var/javaApps/olyfe
CURRENT_DIRECTORY="$(pwd)"
# docker puller and start

# check if folder for docker and services data exists
DATA_DIRECTORY=/opt/docker_data
STORM_DATA_DIRECTORY=$DATA_DIRECTORY/storm

#start Storm
echo "Creating if not exists: $STORM_DATA_DIRECTORY and start Docker image"
mkdir -p "$STORM_DATA_DIRECTORY"

IMAGE_EXISTS=$(docker ps -a | grep "docker-storm")
echo "docker-storm exists: $IMAGE_EXISTS"
if [ ! "$IMAGE_EXISTS" ]; then
			# build image from docker file
			echo "build and run docker-storm"
			#cd "$PARENT_DIRECTORY"/docker-files/hbase-0.94.5/
            cd "$PARENT_DIRECTORY"/docker-files/tomcat/
			./build-image.sh
			cd "$CURRENT_DIRECTORY"
			ls -la
			docker run --name docker-storm --link docker-mysql:docker-mysql --link docker-elasticsearch:docker-elasticsearch --link docker-jwebsocket:docker-jwebsocket --link docker-memcached:docker-memcached --link docker-hbase:docker-hbase --link docker-redis:docker-redis -v "$STORM_DATA_DIRECTORY"/logs:/opt/storm/logs -v "$STORM_DATA_DIRECTORY"/conf:/opt/storm/conf -v "$STORM_DATA_DIRECTORY"/deployment:/opt/deployment -p 7777:7777 -h storm -d ninel/storm:0.9.2-incubating
           
	else
			echo "starting docker-storm"
			docker start docker-storm # &> /dev/null
fi
