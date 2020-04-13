#!/bin/bash

/usr/sbin/sshd

cd /opt/hadoop/bin
./hdfs namenode -format

cd /opt/hadoop/sbin/
./start-all.sh

cd /opt/hadoop/bin
./hadoop fs -mkdir /spark-history


tail -f /dev/null