FROM ninel/hbase:1.1.0.1
MAINTAINER Ninel Hodzic <ninel.hodzic@gmail.com>

RUN mkdir /phoenix-setup
WORKDIR /phoenix-setup

ADD download-phoenix.sh /phoenix-setup/download-phoenix.sh
RUN ./download-phoenix.sh

ADD install-phoenix.sh /phoenix-setup/install-phoenix.sh
RUN ./install-phoenix.sh

WORKDIR /opt/hbase/bin

CMD /opt/hbase/bin/start-pseudo-distributed.sh