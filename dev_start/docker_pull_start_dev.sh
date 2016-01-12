#!/bin/bash

PARENT_DIRECTORY="$(dirname "$(pwd)")"
SOURCE_CODE_DIRECTORY=/var/javaApps/olyfe
CURRENT_DIRECTORY="$(pwd)"
# docker puller and start

# check if folder for docker and services data exists
DATA_DIRECTORY=/opt/docker_data
MYSQL_DATA_DIRECTORY="$DATA_DIRECTORY"/mysql
REDIS_DATA_DIRECTORY="$DATA_DIRECTORY"/redis
MEMCACHED_DATA_DIRECTORY="$DATA_DIRECTORY"/memcached
ELASTICSEARCH_DATA_DIRECTORY="$DATA_DIRECTORY"/elasticsearch
HBASE_DATA_DIRECTORY="$DATA_DIRECTORY"/hbase
PHP_DATA_DIRECTORY="$DATA_DIRECTORY"/php


HOST_MACHINE_HOSTNAME=$(hostname)
HOST_MACHINE_IP=$(ip route | awk '/docker/ { print $NF }')

# create folder if not exists
#sudo mkdir -p "$DATA_DIRECTORY"


# run docker images

# start MySQL

echo "Building base docker image"
cd "$PARENT_DIRECTORY"/docker-files/base
./build-image.sh            
cd $CURRENT_DIRECTORY 

echo "Creating if not exists: $MYSQL_DATA_DIRECTORY and start Docker image"
mkdir -p "$MYSQL_DATA_DIRECTORY"
IMAGE_EXISTS=$(docker ps -a | grep "docker-mysql")
echo "docker-mysql exists: $IMAGE_EXISTS"
if [ ! "$IMAGE_EXISTS" ]; then
		echo "pulling mysql"
		#docker pull mysql:5.6
		docker run --privileged=true --name docker-mysql -p 127.0.0.1:3306:3306 -v "$MYSQL_DATA_DIRECTORY":/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -d mysql:5.6
	else
		echo "starting docker-mysql"
		docker start docker-mysql &> /dev/null
fi
# run mysql scrips
echo "Sleep 10s and executing MySQL scripts"
sleep 10

tar xzf "$SOURCE_CODE_DIRECTORY"/olyfeDatabase/src/main/sql/geo_city.sql.tar.gz -C "$SOURCE_CODE_DIRECTORY"/olyfeDatabase/src/main/sql/
$(echo "create database IF NOT EXISTS olyfe_v2" | mysql -h 127.0.0.1 -u root -proot)
$(mysql -h 127.0.0.1 -u root -proot olyfe_v2 < "$SOURCE_CODE_DIRECTORY"/olyfeDatabase/src/main/sql/geo_city.sql)
$(mysql -h 127.0.0.1 -u root -proot olyfe_v2 < "$SOURCE_CODE_DIRECTORY"/olyfeDatabase/src/main/sql/unique_geo_city_view.sql)
$(mysql -h 127.0.0.1 -u root -proot olyfe_v2 < "$SOURCE_CODE_DIRECTORY"/scripts/create_mysql_tables.sql)
$(mysql -h 127.0.0.1 -u root -proot olyfe_v2 < "$SOURCE_CODE_DIRECTORY"/scripts/ff_taxonomy.sql)
$(mysql -h 127.0.0.1 -u root -proot olyfe_v2 < "$SOURCE_CODE_DIRECTORY"/scripts/user_management_tables.sql)
rm "$SOURCE_CODE_DIRECTORY"/olyfeDatabase/src/main/sql/geo_city.sql


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

#start memcached
echo "Creating if not exists: $MEMCACHED_DATA_DIRECTORY and start Docker image"
mkdir -p "$MEMCACHED_DATA_DIRECTORY"
IMAGE_EXISTS=$(docker ps -a | grep "docker-memcached")
echo "docker-memcached exists: $IMAGE_EXISTS"
if [ ! "$IMAGE_EXISTS" ]; then
		#docker pull memcached:1.4
		docker run --name docker-memcached  -p 11211:11211 -v "$MEMCACHED_DATA_DIRECTORY":/data -d memcached:1.4
	else
		echo "starting docker-memcached"
		docker start docker-memcached &> /dev/null
fi

#start PHP and Apache2
echo "Creating if not exists: $PHP_DATA_DIRECTORY and start Docker image"
mkdir -p "$PHP_DATA_DIRECTORY"
IMAGE_EXISTS=$(docker ps -a | grep "docker-apache2-php")
echo "docker-apache2-php exists: $IMAGE_EXISTS"
if [ ! "$IMAGE_EXISTS" ]; then
		cd "$PARENT_DIRECTORY"/docker-files/apache2-php/
		./build-image.sh
		cd "$CURRENT_DIRECTORY"
		docker run --name docker-apache2-php --env HOST_MACHINE_HOSTNAME=$HOST_MACHINE_HOSTNAME --env HOST_MACHINE_IP=$HOST_MACHINE_IP -p 80:80 -v $PWD/apache2/sites-enabled:/etc/apache2/sites-enabled -v /var/www:/var/www -d ninel/apache2-php
	else
		echo "starting docker-apache2-php"
		docker start docker-apache2-php &> /dev/null
fi


#start elasticsearch
echo "Creating if not exists: $ELASTICSEARCH_DATA_DIRECTORY and start Docker image"
mkdir -p "$ELASTICSEARCH_DATA_DIRECTORY"

IMAGE_EXISTS=$(docker ps -a | grep "docker-elasticsearch")
echo "docker-elasticsearch exists: $IMAGE_EXISTS"
if [ ! "$IMAGE_EXISTS" ]; then
		#docker pull elasticsearch:1.7
		docker run --name docker-elasticsearch -p 9200:9200 -p 9300:9300 --env ES_HEAP_SIZE=2g -v "$ELASTICSEARCH_DATA_DIRECTORY":/usr/share/elasticsearch/data -v "$PWD/es/plugins":/usr/share/elasticsearch/plugins -d  elasticsearch:1.7 -Des.network.bind_host=0.0.0.0 -Des.cluster.name=elasticsearch-olyfe
		# install es plugins
		docker exec docker-elasticsearch /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head
        docker exec docker-elasticsearch /usr/share/elasticsearch/bin/plugin -install analysis-arirang --url 'https://github.com/sangwook/elasticsearch-analysis-arirang/blob/master/target/analysis-arirang.zip?raw=true'
        docker exec docker-elasticsearch /usr/share/elasticsearch/bin/plugin -install  lmenezes/elasticsearch-kopf/1.0
	else
		echo "starting docker-elasticsearch"
		docker start docker-elasticsearch &> /dev/null
fi
		



#start hbase
echo "Creating if not exists: $HBASE_DATA_DIRECTORY and start Docker image"
mkdir -p "$HBASE_DATA_DIRECTORY"

IMAGE_EXISTS=$(docker ps -a | grep "docker-hbase")
echo "docker-hbase exists: $IMAGE_EXISTS"
if [ ! "$IMAGE_EXISTS" ]; then
			# build image from docker file
			echo "build and run docker-hbase"
			#cd "$PARENT_DIRECTORY"/docker-files/hbase-0.94.5/
            cd "$PARENT_DIRECTORY"/docker-files/hbase-cdh4/
			./build-image.sh
			#cd "$PARENT_DIRECTORY"/docker-files/olyfe-hbase-phoenix-0.94.5-3.2.0/
            cd "$PARENT_DIRECTORY"/docker-files/go-hbase-phoenix-cdh4-3.2.0/
			./build-image.sh
			cd "$CURRENT_DIRECTORY"
			ls -la
			docker run --name docker-hbase -v "$HBASE_DATA_DIRECTORY":/opt/data/hbase -p 2181:2181 -p 60010:60010 -p 60000:60000 -p 60020:60020 -p 60030:60030 -h hbase -d ninel/phoenix_hbase-cdh4:3.2.0 
            #ninel/phoenix_hbase:3.2.0
			docker start docker-hbase # &> /dev/null
	else
			echo "starting docker-hbase"
			docker start docker-hbase # &> /dev/null
fi

# get Docker hbase IP address and add to /etc/hosts
#DOCKER_JSON = $(docker inspect docker-hbase)
docker inspect docker-hbase > config.json
docker_hostname=`python -c 'import json; c=json.load(open("config.json")); print c[0]["Config"]["Hostname"]'`
docker_ip=`python -c 'import json; c=json.load(open("config.json")); print c[0]["NetworkSettings"]["IPAddress"]'`
rm -f config.json

echo "Updating /etc/hosts to make hbase-docker point to $docker_ip ($docker_hostname)"
if grep 'hbase-docker' /etc/hosts >/dev/null; then
  sudo sed -i "s/^.*hbase-docker.*\$/$docker_ip hbase-docker $docker_hostname/" /etc/hosts
else
  sudo sh -c "echo '$docker_ip hbase-docker $docker_hostname' >> /etc/hosts"
fi


echo "Creating and starting jWebSocket docker"
IMAGE_EXISTS=$(docker ps -a | grep "docker-jwebsocket")
echo "docker-jwebsocket exists: $IMAGE_EXISTS"
if [ ! "$IMAGE_EXISTS" ]; then
			# build image from docker file
			echo "build and run docker-jwebsocket"
			#cd "$PARENT_DIRECTORY"/docker-files/hbase-0.94.5/
            cd "$PARENT_DIRECTORY"/docker-files/jwebsocket
			./build-image.sh            
			docker run --name docker-jwebsocket -p 8787:8787 -d ninel/jwebsocket:1.0.0            
	else
			echo "starting docker-jwebsocket"
			docker start docker-jwebsocket # &> /dev/null
fi





#echo "Running prerender io service as Docker"
#IMAGE_EXISTS=$(docker ps -a | grep "docker-prerender")
#echo "docker-prerender exists: $IMAGE_EXISTS"
#if [ ! "$IMAGE_EXISTS" ]; then
#		docker pull cerisier/prerender
#		docker run --name docker-prerender -p 3002:3000  -d cerisier/prerender
#	else
#		echo "starting docker-prerender"
#		docker start docker-prerender &> /dev/null
#fi

# assign current user as the owner of the folder content
#if [ -d "$DATA_DIRECTORY" ]; then
  # Control will enter here if $DATA_DIRECTORY exists.
 # sudo chown -R ${USER:=$(/usr/bin/id -run)}:$USER $DATA_DIRECTORY
#fi
