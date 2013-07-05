#!/bin/sh
DIR=$1
HOST=$2
PORT=$3
DB_NAME=$4
COLLECTION_NAME=$5
TOTAL_FILES=0
echo "It took $DIFF seconds"
data=$(ls -trh $DIR)
echo "Performing MongoImport on $HOST:$PORT to target DB: $DB_NAME in collection: $COLLECTION_NAME"
echo "Started on: " `date`
START=`date +%s`
for entry in ${data}
do
echo "Processing File: ${entry}"
/opt/mongodb2.4.2/bin/mongoimport --host $HOST --port $PORT --db $DB_NAME --collection $COLLECTION
_NAME $DIR/$entry
TOTAL_FILES=`expr $TOTAL_FILES + 1`
done
echo "Completed on: " `date`
END=`date +%s`
DIFF=$(( $END - $START ))
echo "Processed Files : $TOTAL_FILES in TIME(Secs):$DIFF":