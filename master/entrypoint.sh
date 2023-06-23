#! /bin/sh

sudo /usr/sbin/sshd

# now we have to do it here. for persistance and ease

# start dfs
cd /opt/hadoop/sbin
./start-dfs.sh

# start yarn
export HADOOP_HOME="/opt/hadoop"
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME

cd /opt/hadoop/sbin
./start-yarn.sh

echo All Done
echo go to localhost:9870
echo or localhost:8088/cluster

tail -F /dev/null