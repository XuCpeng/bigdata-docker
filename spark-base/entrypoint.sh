#!/bin/bash

cd /opt/spark/sbin
./start-all.sh

sleep 30
./start-history-server.sh

/usr/sbin/sshd -D