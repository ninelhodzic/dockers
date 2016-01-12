FROM ubuntu:14.04
MAINTAINER Ninel Hodzic <ninel.hodzic@gmail.com>

RUN apt-get update && apt-get install -y openjdk-7-jdk wget tar sudo
ENV JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64

#RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
#USER docker

RUN mkdir /hbase-setup
WORKDIR /hbase-setup

ADD ./install-hbase.sh /hbase-setup/
RUN ./install-hbase.sh

# create data directory
# RUN mkdir -p /data
RUN mkdir -p /data/logs

RUN /opt/hbase/bin/hbase-config.sh

COPY hbase-site.xml /opt/hbase/conf/hbase-site.xml
COPY hbase-env.sh /opt/hbase/conf/hbase-env.sh
COPY start-pseudo-distributed.sh /opt/hbase/bin/start-pseudo-distributed.sh

# zookeeper
EXPOSE 2181
# HBase Master API port
EXPOSE 60000
# HBase Master Web UI
EXPOSE 60010
# Regionserver API port
EXPOSE 60020
# HBase Regionserver web UI
EXPOSE 60030

WORKDIR /opt/hbase/bin

ENV PATH=$PATH:/opt/hbase/bin

CMD /opt/hbase/bin/start-pseudo-distributed.sh
