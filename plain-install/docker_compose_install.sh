#! /bin/bash
# should run with sudo

curl -L https://github.com/docker/compose/releases/download/1.5.0rc1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
#chmod +x /usr/local/bin/docker-compose
chmod a+rx /usr/local/bin/docker-compose


