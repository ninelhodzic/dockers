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

COPY jWebSocket-1.0.tar.gz jWebSocket-1.0.tar.gz
COPY install-jwebsocket.sh install-jwebsocket.sh 
RUN ["/bin/bash", "install-jwebsocket.sh"]


COPY start.sh start.sh
#RUN ["/bin/bash", "start.sh"]

CMD ["/bin/bash", "start.sh"]