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