#! /bin/bash

STORM_VERSION="apache-storm-0.9.2-incubating"

# http://apache.mirror.cdnetworks.com/storm/apache-storm-0.9.2-incubating/apache-storm-0.9.2-incubating.tar.gz

wget  http://apache.mirror.cdnetworks.com/storm/"$STORM_VERSION"/"$STORM_VERSION".tar.gz
tar xzf "$STORM_VERSION".tar.gz -C /opt/
ln -s /opt/"$STORM_VERSION" /opt/storm

rm $STORM_VERSION.tar.gz

mkdir -p "/opt/deployment"
mkdir -p "/opt/app_config/"