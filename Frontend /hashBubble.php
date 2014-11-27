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

# Collect
if(isset($_POST['search'])) {
	$searchQuery = $_POST['search'];

	//$tweetBucket = $client->bucket('twitter'); 
	//$fetched_data= $tweetBucket->get($searchQuery)->data['keys'];
	//print("$fetched_data");

	$shitResults = $bucket->indexSearch("hashtags_bin", $searchQuery);
	print("$results");

	}	


		// if(empty($_POST['query'])) {
	// 	echo "enter a hashtag";
	// }

	// $query = $_POST['query'];
	// echo $query;
	// $searchQuery = $_POST['search'];
	// echo $search;



// # Choose Bucket
// $bookBucket = $client->bucket('books');

// # Fetching related data by shared key
// $fetched_data = $bookBucket->get('1111979723')->data['title'];
// print("Selected Information: \n");
// print_r($fetched_data);








// header('Content-type: image/jpeg;');
// $p = "http://i58.tinypic.com/2d9uxsi.jpg";
// $a = file_get_contents($p);
// echo $a;


// # Choose Bucket
// $tweetBucket = $client->bucket('tweets');

// // Fetching related data by shared key
// $fetched_tweet = $tweetBucket->get('keys')->data['text'];
// print("Tweet: \n");
// print_r($fetched_tweet);



# Supply a key under which to store your data
// $person = $bookBucket->newObject('riak_key', array(
//     'name' => "Professor Imed",
//     'age' => 25,
//     'company' => "Software Engineering and Management"
// ));

// # Create some test data
// $bucket = $client->bucket("searchbucket");
// $bucket->newObject("one", array("foo"=>"one", "bar"=>"red"))->store();
// $bucket->newObject("two", array("foo"=>"two", "bar"=>"green"))->store();

// # Execute a search for all objects with matching properties
// $results = $client->getData("one" | "bar")->run();

// print_r($results);




# Fetch the object
// $person = $bucket->get('riak_dev');


// Fetching related data by shared key
// $fetched_data = $bucket->get('riak_dev')->data;
// $fetched_data['riak_dev'] = $bucket->get('riak_dev')->data;
// print("Customer Info: \n");
// print_r($fetched_tweet);




?>
















