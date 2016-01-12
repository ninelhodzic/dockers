#!/bin/sh

echo "============================="
echo " install CDH5.4.0+HBase"
echo "============================="

#wget http://archive.cloudera.com/cdh4/one-click-install/redhat/6/x86_64/cloudera-cdh-4-0.x86_64.rpm
#yum -y --nogpgcheck localinstall cloudera-cdh-4-0.x86_64.rpm
#rpm --import http://archive.cloudera.com/cdh4/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera 

#yum install -y \
#	hadoop-0.20-conf-pseudo \
#	hbase hbase-master \
#	hbase-regionserver \
#	zookeeper zookeeper-server



#wget http://archive.cloudera.com/cdh4/one-click-install/precise/amd64/cdh4-repository_1.0_all.deb
cat > /etc/apt/sources.list.d/cloudera.list << 'EOF'
# Packages for Cloudera's Distribution for Hadoop, Version 5, on Ubuntu 14.04 amd64       
deb [arch=amd64] http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh5 contrib
deb-src http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh5 contrib

EOF

curl -s http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key | apt-key add -

apt-get update;
apt-get install -y hadoop-0.20-mapreduce-jobtracker hadoop-hdfs-namenode hadoop-0.20-mapreduce-tasktracker hadoop-hdfs-datanode  hadoop-client hbase hbase-master
