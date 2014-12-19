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
$imageBucket = $client->bucket("twitter_data");

# Search for exact match from secondary index 
if(isset($_POST['search'])) {
	$searchQuery = $_POST['search'];

	$id = 0;
    // Loop to create bubbles for each url found in riak
	$results = $imageBucket->indexSearch("hashtags", 'bin', $searchQuery);
	foreach ($results as $link) {
		$url = $link->getKey();
		$id = $id + 1;
		$bubble = "<button onclick='showContent(this.name, this.id);' name='$url' class='bubble' id='b" .$id. "'></button>";
		echo $bubble;
		//Set limit to 10 bubbles
		if ($id == 11) 
			break;
	}
}

?>
















