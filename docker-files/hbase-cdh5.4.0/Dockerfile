FROM ubuntu:14.04
MAINTAINER Ninel Hodzic <ninel.hodzic@gmail.com>

#=======================
# Install utils
#=======================
COPY install-default.sh install-default.sh 
RUN ["/bin/bash", "install-default.sh"]

ENV TERM xterm

#=======================
# Install JDK
#=======================
COPY install-jdk.sh install-jdk.sh 
RUN ["/bin/bash", "install-jdk.sh"]

#=======================
# Install CDH 5
#=======================


COPY install-cdh-hbase.sh install-cdh-hbase.sh
RUN ["/bin/bash", "install-cdh-hbase.sh"]

#=======================
# Setup 
#=======================
COPY hbase-site.xml /etc/hbase/conf/hbase-site.xml
COPY hbase-env.sh /etc/hbase/conf/hbase-env.sh
COPY core-site.xml /etc/hadoop/conf/core-site.xml


COPY setup.sh setup.sh
RUN bash setup.sh 

#=======================
# Start services.
#=======================
COPY start.sh start.sh
# zookeeper
#EXPOSE 2181
# HBase master
#EXPOSE 65000
# HBase master web UI
#EXPOSE 65010
# HBase regionserver
#EXPOSE 65020
# HBase regionserver web UI
#EXPOSE 65030

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


CMD ["/bin/bash", "start.sh"]