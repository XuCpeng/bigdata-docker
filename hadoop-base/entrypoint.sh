#!/bin/bash

/usr/sbin/sshd

cd /opt/hadoop/bin
./hdfs namenode -format

cd /opt/hadoop/sbin/
./start-all.sh

tail -f /dev/null