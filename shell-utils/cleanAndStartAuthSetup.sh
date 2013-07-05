#!/bin/sh

basePath=./replSetData
basePathSt=./standaloneData

rm -rf $basePath/ $basePathSt/
mkdir $basePath/ $basePathSt/
mkdir $basePath/db $basePath/db2 $basePath/db3 $basePathSt/20 $basePathSt/21 $basePath/unsec1 $basePath/unsec2
echo Zom89ZAH > $basePath/keyfile
chmod 700 $basePath/keyfile

mongod --port 27017 --dbpath $basePath/db --replSet rs0 --auth --keyFile $basePath/keyfile --smallfiles --rest &
mongod --port 27018 --dbpath $basePath/db2 --replSet rs0 --auth --keyFile $basePath/keyfile --smallfiles --rest &
mongod --port 27019 --dbpath $basePath/db3 --replSet rs0 --auth --keyFile $basePath/keyfile --smallfiles --rest &
mongod --port 27020 --dbpath $basePathSt/20 --auth --smallfiles --rest &

mongod --port 27021 --dbpath $basePathSt/21 --smallfiles --rest &

mongod --port 17017 --dbpath $basePath/unsec1 --replSet rs1 --smallfiles --rest  &
mongod --port 17018 --dbpath $basePath/unsec2 --replSet rs1 --smallfiles --rest &

sleep 30
mongo --eval "rs.initiate({ _id:'rs0', members:[{_id: 0, host:'localhost:27017', priority:10}, {_id: 1, host:'localhost:27018', priority:3}, {_id: 2, host:'localhost:27019', priority:3}]})" &

mongo --port 17017 --eval "rs.initiate({ _id:'rs1', members:[{_id: 0, host:'localhost:17017', priority:10}, {_id: 1, host:'localhost:17018', priority:3}]})" &

sleep 60

mongo --port 27020 admin createAdmin.js &
mongo admin createAdmin.js &
