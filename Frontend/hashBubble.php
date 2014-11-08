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


// Class definitions for our models

class Tweet
{
    var $tweetId;
    var $text;
}

// Creating Data
$tweet = new Tweet();
$tweet->tweetId = 1;
$tweet->text = 'This is a tweet';

// Starting Client
$client = new Basho\Riak\Riak('127.0.0.1', 10018);

// Creating Buckets
$tweetBucket = $client->bucket('Tweets');

// Storing Data
$tweet_riak = $tweetBucket->newObject(
    strval($tweet->tweetId), $tweet
);
$tweet_riak->store();

// Fetching related data by shared key
$fetched_data = $tweets->get('1')->data;
$fetched_data['Tweets'] = $tweetBucket->get('1')->data;
print("Tweet: \n");
print_r($fetched_tweet);


?>