FROM ninel/base-jdk-defaults
MAINTAINER Ninel Hodzic <ninel.hodzic@gmail.com>

#=======================
# Install Tomcat7
#=======================
RUN apt-get update && \
    apt-get install -y tomcat7
    
COPY defaults /etc/defaults/tomcat7
COPY server.xml /etc/tomcat7/

