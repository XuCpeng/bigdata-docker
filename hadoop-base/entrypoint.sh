#!/bin/bash

/usr/sbin/sshd

cd /opt/hadoop-3.2.1/bin
./hdfs namenode -format

cd /opt/hadoop-3.2.1/sbin/
./start-all.sh

tail -f /dev/null