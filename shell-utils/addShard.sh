#!/bin/sh
#sudo service mongodb stop
#if [ -z "$MONGO_HOME" ]; then
 
  MONGO_HOME=$1
  MONGOS_PORT=$2
  REPLICASET_NAME=$3
  PORT_PREFIX=$4
#else
#  MONGO_HOME='$MONGO_HOME'
#fi

echo "Adding Shard running on port prefix $PORT_PREFIX[50, 51, 52]...to Mongos on $MONGOS_PORT "

# Add Shard   
################################################################3
$MONGO_HOME/bin/mongo --port $MONGOS_PORT --eval "sh.addShard('$REPLICASET_NAME/localhost:$PORT_PREFIX""50')" &
