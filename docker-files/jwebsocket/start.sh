#!/bin/bash 

echo "============================="
echo " Starting jWebSocket"
echo "============================="

cd /opt/jWebSocket-1.0/bin/

./jWebSocketServer.sh > jwebsocket.log 2>&1