#!/bin/sh
#sudo service mongodb stop
#if [ -z "$MONGO_HOME" ]; then
 
  MONGO_HOME=$1
  REPLICASET_NAME=$2
  PORT_PREFIX=$3
#else
#  MONGO_HOME='$MONGO_HOME'
#fi
mongoData=/var/tmp/mongo-data/sharded
mongoBase=$mongoData/$PORT_PREFIX
basePath=$mongoBase/replSetData
rm -rf $mongoBase/ 
mkdir $mongoData/ $mongoBase/ $basePath/ 
mkdir $basePath/unsec1 $basePath/unsec2 $basePath/unsec3

#
# Unsecure Replica Set
################################################################3
$MONGO_HOME/bin/mongod --port $PORT_PREFIX""50 --dbpath $basePath/unsec1 --replSet $REPLICASET_NAME --smallfiles &
$MONGO_HOME/bin/mongod --port $PORT_PREFIX""51 --dbpath $basePath/unsec2 --replSet $REPLICASET_NAME --smallfiles &
$MONGO_HOME/bin/mongod --port $PORT_PREFIX""52 --dbpath $basePath/unsec3 --replSet $REPLICASET_NAME --smallfiles &

sleep 60
echo "Initiating ReplicaSets..."

#
# Initiate Unsecure Replica Set  
################################################################3
$MONGO_HOME/bin/mongo --port $PORT_PREFIX""50 --eval "rs.initiate({ _id:'$REPLICASET_NAME', members:[{_id:0, host:'localhost:$PORT_PREFIX""50', priority:10}, {_id: 1, host:'localhost:$PORT_PREFIX""51', priority:3}, {_id:2, host: 'localhost:$PORT_PREFIX""52', priority:3}]})" &

