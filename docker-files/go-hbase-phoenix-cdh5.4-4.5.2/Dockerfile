FROM ninel/hbase:cdh4.7.0
MAINTAINER Ninel Hodzic <ninel.hodzic@gmail.com>

#RUN mkdir /phoenix-setup
#WORKDIR /phoenix-setup

#ADD install-phoenix.sh /phoenix-setup/install-phoenix.sh
#RUN ./install-phoenix.sh

#WORKDIR /opt/hbase/bin

#CMD /opt/hbase/bin/start-pseudo-distributed.sh


ADD phoenix-core-3.2.0.jar /usr/lib/hbase/lib/

CMD ["/bin/bash", "start.sh"]