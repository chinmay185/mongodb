#!/bin/sh
#sudo service mongodb stop
#if [ -z "$MONGO_HOME" ]; then
 
  MONGO_HOME=$1
  PORT_PREFIX=$2
#else
#  MONGO_HOME='$MONGO_HOME'
#fi
mongoData=/var/tmp/mongo-data/sharded
mongoBase=$mongoData/$PORT_PREFIX
basePath=$mongoBase/configData
rm -rf $mongoBase/ 
mkdir $mongoData/ $mongoBase/ $basePath/
mkdir $basePath/db $basePath/db2 $basePath/db3 
#
# Config Servers 
################################################################
$MONGO_HOME/bin/mongod --port $PORT_PREFIX""18 --dbpath $basePath/db --configsvr &
$MONGO_HOME/bin/mongod --port $PORT_PREFIX""19 --dbpath $basePath/db2 --configsvr &
$MONGO_HOME/bin/mongod --port $PORT_PREFIX""20 --dbpath $basePath/db3 --configsvr &

sleep 30
#
# Start the Mongos Instances
##################################################################
$MONGO_HOME/bin/mongos --port $PORT_PREFIX""17 --configdb localhost:$PORT_PREFIX""18,localhost:$PORT_PREFIX""19,localhost:$PORT_PREFIX""20
