<?php

require_once '../riak-php-client/src/Basho/Riak/Riak.php';
require_once '../riak-php-client/src/Basho/Riak/Bucket.php';
require_once '../riak-php-client/src/Basho/Riak/Exception.php';
require_once '../riak-php-client/src/Basho/Riak/Link.php';
require_once '../riak-php-client/src/Basho/Riak/Object.php';
require_once '../riak-php-client/src/Basho/Riak/StringIO.php';
require_once '../riak-php-client/src/Basho/Riak/Utils.php';


# Starting Client
$client = new Basho\Riak\Riak('127.0.0.1',10018);

# Choose bucket
$tweetBucket = $client->bucket("image_data");

# Search for exact match from secondary index 
if(isset($_POST['search'])) {
	$searchQuery = $_POST['search'];


	$results = $tweetBucket->indexSearch("hashtags", 'bin', $searchQuery);
	foreach ($results as $link) {
		$bubble = $link->getKey();
		echo "<button onclick='showContent();' class='bubble'>" ."$bubble". "</button>";
		// echo '<pre>'; print_r($bubble); echo '</pre>';
	}
}

?>
















