docker run --name docker-hbase -v /opt/docker_data:/data -p 2181:2181 -p 60010:60010 -p 60000:60000 -p 60020:60020 -p 60030:60030 -h hbase ninel/phoenix_hbase-cdh4:3.2.0
