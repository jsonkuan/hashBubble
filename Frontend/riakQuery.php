<?php
require_once 'riak-php-client/src/Basho/Riak/Riak.php';
require_once 'riak-php-client/src/Basho/Riak/Bucket.php';
require_once 'riak-php-client/src/Basho/Riak/Exception.php';
require_once 'riak-php-client/src/Basho/Riak/Link.php';
require_once 'riak-php-client/src/Basho/Riak/Object.php';
require_once 'riak-php-client/src/Basho/Riak/StringIO.php';
require_once 'riak-php-client/src/Basho/Riak/Utils.php';


# Starting Client
$client = new Basho\Riak\Riak('127.0.0.1',10018);

# Choose bucket
$imageBucket = $client->bucket("image_data");

# Search for exact match from secondary index 
if(isset($_POST['search'])) {
	$searchQuery = $_POST['search'];

    // Loop to create bubbles for each url found in riak
	$results = $imageBucket->indexSearch("hashtags", 'bin', $searchQuery);
	foreach ($results as $link) {
		$url = $link->getKey();
		$bubble = "<button onclick='showContent(this.name);' name='$url' class='bubble'></button>";
		echo $bubble;
		// echo '<pre>'; print_r($bubble); echo '</pre>';
	}
}

?>
















