#! /bin/bash

tar xzf jWebSocket-1.0.tar.gz -C /opt/
#ln -s /opt/jWebSocket-1.0 /opt/jWebSocket-1.0

ls -la /opt/jWebSocket-1.0/bin/

chmod +x /opt/jWebSocket-1.0/bin/jWebSocketServer.sh

rm jWebSocket-1.0.tar.gz