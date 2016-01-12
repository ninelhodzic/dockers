cd /opt/storm
#./bin/storm kill olyfeTopology
#sleep 10
#./bin/storm kill olyfeCrawlerTopology
#sleep 10


service monit stop

# kill storm
sudo kill -9 `ps aux | grep "backtype.storm" | awk ' { print $2 }'`

rm -R /storm-transaction

# monit will start Storm again
service monit start

# sleep untill it is live again
sleep 30

./bin/storm jar /opt/deployment/olyfeStorm-0.0.1-SNAPSHOT.jar com.olyfe.storm.topology.OlyfeTopology -run remote -crawler true
#sleep 60
echo "Storm deployed OlyfeTopology"
#./bin/storm jar /opt/deployment/olyfeStorm-0.0.1-SNAPSHOT.jar com.olyfe.storm.topology.OlyfeCrawlerTopology -run remote
#echo "Storm deployed OlyfeCrawlerTopology"
