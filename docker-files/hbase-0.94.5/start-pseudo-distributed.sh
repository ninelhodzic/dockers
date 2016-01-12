#!/bin/bash

/opt/hbase/bin/hbase zookeeper > /data/logs/zookeeper.log 2>&1 &
/opt/hbase/bin/hbase regionserver start > /data/logs/region-server.log 2>&1 &

/opt/hbase/bin/hbase master start > /data/logs/hbase-master.log 2>&1
#2>&1 | tee logmaster.log &
#> logmaster.log 2>&1 &
#--localRegionServers=0
