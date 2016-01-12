#!/bin/bash
PHOENIX_VERSION=phoenix-3.2.0

wget http://archive.apache.org/dist/phoenix/$PHOENIX_VERSION/bin/$PHOENIX_VERSION-bin.tar.gz
tar -xzf $PHOENIX_VERSION-bin.tar.gz
mv $PHOENIX_VERSION-bin /opt/
rm -f $PHOENIX_VERSION-bin.tar.gz
ln -s /opt/$PHOENIX_VERSION-bin /opt/phoenix

#cp /opt/phoenix/$PHOENIX_VERSION-server.jar /opt/hbase/lib/
ls /opt/phoenix/common/
cp /opt/phoenix/common/phoenix-core-3.2.0.jar /opt/hbase/lib/
echo "list /opt/hbase/lib"
ls /opt/hbase/lib
