#!/bin/bash 

docker inspect docker-hbase > config.json
zoo_hostname=`python -c 'import json; c=json.load(open("config.json")); print c[0]["Config"]["Hostname"]'`
zoo_ip=`python -c 'import json; c=json.load(open("config.json")); print c[0]["NetworkSettings"]["IPAddress"]'`
rm -f config.json

#echo "Updating /etc/hosts to make hbase-docker point to $docker_ip ($docker_hostname)"
#if grep 'hbase-docker' /etc/hosts >/dev/null; then
#  sudo sed -i "s/^.*hbase-docker.*\$/$docker_ip hbase-docker $docker_hostname/" /etc/hosts
#else
#  sudo sh -c "echo '$docker_ip hbase-docker $docker_hostname' >> /etc/hosts"
#fi


DATA_DIRECTORY=/opt/docker_data
STORM_DATA_DIRECTORY=$DATA_DIRECTORY/storm

mkdir -p "$STORM_DATA_DIRECTORY"


docker run --name docker-storm --link docker-mysql:docker-mysql --link docker-elasticsearch:docker-elasticsearch --link docker-jwebsocket:docker-jwebsocket --link docker-memcached:docker-memcached --link docker-hbase:docker-hbase --link docker-redis:docker-redis -v "$STORM_DATA_DIRECTORY"/deployment:/opt/deployment -p 7777:7777 -h storm -d ninel/storm:0.9.2-incubating


#docker run --name docker-storm -h docker-storm -e ZK_PORT_2181_TCP_ADDR=$zoo_ip  -p 6703:6703 -p 6702:6702 -p 6701:6701 -p 6700:6700 -p 7777:7777  ninel/storm:0.9.2-incubating