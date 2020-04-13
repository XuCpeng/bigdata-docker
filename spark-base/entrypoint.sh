#!/bin/bash

cd /opt/spark/sbin
./start-all.sh

sleep 20
./start-history-server.sh

/usr/sbin/sshd -D