#!/bin/bash

PARENT_DIRECTORY="$(dirname "$(pwd)")"
SOURCE_CODE_DIRECTORY=/home/ninel/Kuran
CURRENT_DIRECTORY="$(pwd)"
# docker puller and start

# check if folder for docker and services data exists
DATA_DIRECTORY=/opt/docker_data
MONGO_DATA_DIRECTORY="$DATA_DIRECTORY"/mongo
ELASTICSEARCH_DATA_DIRECTORY="$DATA_DIRECTORY"/elasticsearch



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
		docker run --privileged=true --name docker-mongo -h docker-mongo -p 27017:27017 -v "$MONGO_DATA_DIRECTORY":/data/db -d mongo:3
	else
		echo "starting docker-mongo"
		docker start docker-mongo &> /dev/null
fi


#start elasticsearch
echo "Creating if not exists: $ELASTICSEARCH_DATA_DIRECTORY and start Docker image"
mkdir -p "$ELASTICSEARCH_DATA_DIRECTORY"

IMAGE_EXISTS=$(docker ps -a | grep "docker-elasticsearch")
echo "docker-elasticsearch exists: $IMAGE_EXISTS"
if [ ! "$IMAGE_EXISTS" ]; then
		docker pull elasticsearch:1.7
		docker run --name docker-elasticsearch -p 9200:9200 -p 9300:9300 --env ES_HEAP_SIZE=2g -v "$ELASTICSEARCH_DATA_DIRECTORY":/usr/share/elasticsearch/data -v "$PWD/es/plugins":/usr/share/elasticsearch/plugins -d  elasticsearch:1.7 -Des.network.bind_host=0.0.0.0 -Des.cluster.name=elasticsearch-olyfe
		# install es plugins
		#docker exec docker-elasticsearch /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head
        #docker exec docker-elasticsearch /usr/share/elasticsearch/bin/plugin -install analysis-arirang --url 'https://github.com/sangwook/elasticsearch-analysis-arirang/blob/master/target/analysis-arirang.zip?raw=true'
        #docker exec docker-elasticsearch /usr/share/elasticsearch/bin/plugin -install  lmenezes/elasticsearch-kopf/1.0
	else
		echo "starting docker-elasticsearch"
		docker start docker-elasticsearch &> /dev/null
fi
		