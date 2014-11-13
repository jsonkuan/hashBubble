<?php

require_once 'riak-php-client/src/Basho/Riak/Riak.php';
require_once 'riak-php-client/src/Basho/Riak/Bucket.php';
require_once 'riak-php-client/src/Basho/Riak/Exception.php';
require_once 'riak-php-client/src/Basho/Riak/Link.php';
require_once 'riak-php-client/src/Basho/Riak/MapReduce.php';
require_once 'riak-php-client/src/Basho/Riak/Object.php';
require_once 'riak-php-client/src/Basho/Riak/StringIO.php';
require_once 'riak-php-client/src/Basho/Riak/Utils.php';
require_once 'riak-php-client/src/Basho/Riak/Link/Phase.php';
require_once 'riak-php-client/src/Basho/Riak/MapReduce/Phase.php';


# Starting Client
$client = new Basho\Riak\Riak('127.0.0.1',8098);

# Choose Bucket
$tweetBucket = $client->bucket('tweets');

// Fetching related data by shared key
$fetched_tweet = $tweetBucket->get('keys')->data['text'];
print("Tweet: \n");
print_r($fetched_tweet);



// # Choose Bucket
// $customerBucket = $client->bucket('Customers');

// // Fetching related data by shared key
// $fetched_customer = $customerBucket->get('1')->data['address'];
// print("Desired Data: \n");
// print_r($fetched_customer);






// # Supply a key under which to store your data
// $person = $bucket->newObject('riak_dev', array(
//     'name' => "Jay Jackson",
//     'age' => 72,
//     'company' => "WhoringGalour"
// ));
// # Create some test data
// $bucket = $client->bucket("searchbucket");
// $bucket->newObject("one", array("foo"=>"one", "bar"=>"red"))->store();
// $bucket->newObject("two", array("foo"=>"two", "bar"=>"green"))->store();

// # Execute a search for all objects with matching properties
// $results = $client->getData("one" | "bar")->run();

// print_r($results);








// # Save the object to Riak
// $person->store();

# Fetch the object
// $person = $bucket->get('riak_dev');


// Fetching related data by shared key
// $fetched_data = $bucket->get('riak_dev')->data;
// $fetched_data['riak_dev'] = $bucket->get('riak_dev')->data;
// print("Customer Info: \n");
// print_r($fetched_tweet);




?>
















