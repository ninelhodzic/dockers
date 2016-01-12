FROM ninel/hbase:0.94.5
MAINTAINER Ninel Hodzic <ninel.hodzic@gmail.com>

RUN mkdir /phoenix-setup
WORKDIR /phoenix-setup

ADD install-phoenix.sh /phoenix-setup/install-phoenix.sh
RUN ./install-phoenix.sh

WORKDIR /opt/hbase/bin

CMD /opt/hbase/bin/start-pseudo-distributed.sh
