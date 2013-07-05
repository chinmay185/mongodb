#!/bin/sh
#sudo service mongodb stop
#if [ -z "$MONGO_HOME" ]; then
 
  MONGO_HOME=$1
  MONGOS_PORT=$2
  DB_NAME=$3
  COLLECTION_NAME=$4
  SHARD_KEY=$5
#else
#  MONGO_HOME='$MONGO_HOME'
#fi

echo "Sharding Database $DB_NAME on Mongos on $MONGOS_PORT "

# Enable ShardDB and Collection 
################################################################3
$MONGO_HOME/bin/mongo --port $MONGOS_PORT --eval "sh.enableSharding('$DB_NAME')" &
$MONGO_HOME/bin/mongo --port $MONGOS_PORT --eval "sh.shardCollection('$DB_NAME.$COLLECTION_NAME', $SHARD_KEY)" &
