#! /bin/bash

wget --quiet http://archive.eu.apache.org/dist/hbase/hbase-0.94.5/hbase-0.94.5.tar.gz
tar xzf hbase-0.94.5.tar.gz -C /opt/
ln -s /opt/hbase-0.94.5 /opt/hbase

rm hbase-0.94.5.tar.gz
