db.users.dropIndexes();
db.users.drop();
sh.shardCollection('eetest.users', {_id:1});

var populateCity = function() {
    var citiesArray = ["Pune", "Mumbai", "London", "Paris", "Vienna", "Bangalore"];
    return citiesArray[Math.floor((Math.random()*citiesArray.length))];
};

var populateZip = function() {
    return Math.floor(Math.random() * (80000 - 50000)) + 50000;
};

var createPersons  = function(howMany) { 
  for (i=0; i < howMany; i++) {
    db.users.insert({
      username : "username"+i,
      name : "Name" + i,
      email: "username@company.co.uk",
      comment: "BOT You can instead use the addShard database command, which lets you specify a name and maximum size for the shard. If you do not specify these, MongoDB automatically assigns a name and maximum size. To use the database command, see addShard. Before you can shard a collection, you must enable sharding for the collection’s database. Enabling sharding for a database does not redistribute data but make it possible to shard the collections in that database.  Once you enable sharding for a database, MongoDB assigns a primary shard for that database where MongoDB stores all data before sharding begins. EOT",
      city: populateCity(),
      zip: populateZip()
    });
  }
}

createPersons(200000);
