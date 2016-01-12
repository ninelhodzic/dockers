FROM ninel/base-jdk-defaults
MAINTAINER Ninel Hodzic <ninel.hodzic@gmail.com>

#=======================
# Install Storm
#=======================
COPY install-storm.sh install-storm.sh 
RUN ["/bin/bash", "install-storm.sh"]

# configure storm
COPY storm.yaml storm.yaml

# add files to start/stop Storm nimbus/supervisor
COPY storm-nimbus /etc/init.d/
COPY storm-supervisor /etc/init.d/
COPY storm-ui /etc/init.d/

COPY storm-deployment.sh storm-deployment.sh
COPY topologyParalelism.config /opt/deployment/

COPY default.properties /opt/app_config/


# config Monit
COPY storm-monit.conf /etc/monit/conf.d/

# storm supervisor
EXPOSE 6700
EXPOSE 6701
EXPOSE 6702
EXPOSE 6703

# storm ui
EXPOSE 7777

#======================
# Start Storm
#======================

COPY start.sh start.sh 

#RUN ["/bin/bash", "start.sh"]

CMD ["/bin/bash", "start.sh"]

