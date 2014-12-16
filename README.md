# HashBubble

This is a second year project for the course DIT029 - Project: Software Architecture for Distributed Systems at [Gothenburg University](http://www.gu.se).

**License:** This software is released into the public domain (see `LICENSE`).

**Current Version:** 0.1

## Backend guide

1.  Get Erlang

    You need an Erlang installation to run this project. Version 17 of Erlang does not work with Riak. The compatible version of Erlang can be found here:
    
    http://docs.basho.com/riak/latest/ops/building/installing/erlang/

1.  Get Rebar

    Rebar is a build script for Erlang projects. You may install it from your distribution packages, or get it from here:

    https://github.com/basho/rebar

1.  Clone the repo

        $ git clone https://github.com/jas0n-/hashBubble.git

1.  Get the dependencies

        $ cd hashBubble/Backend
        $ rebar get-deps

1.  Compile the dependencies and the package

        $ rebar compile

1.  Get a Twitter account and generate authentication keys

    1.  Open a Twitter account at https://twitter.com .

    1.  Go to https://apps.twitter.com and create a new app.

    1.  Generate API keys for the app using the API Keys tab, as described
        [here](https://dev.twitter.com/oauth/overview/application-owner-access-tokens).

    1.  Collect the `API key`, `API secret`, `Access token` and `Access token secret`,
        and put them into the `hashbubble.config` file, which you find in the repo's
        toplevel directory.
        
    1.  Follow the 5 minute riak [guide](http://docs.basho.com/riak/latest/quickstart/) and set up a 5 node                   cluster. Important: To allow for searching with secondary indexes the backend of the database must be                 changed to leveldb. Edit dev*/etc/riak.conf and change bitcask to leveldb for each node in the cluster.               Nodes that are running must be restarted for this change to take effect.
    
    1.  Edit the `hashbubble.config` file to include the host/port of the Riak node that you want to connect to.

1.  Get an Instagram account and generate an access token. Vist http://instagram.com/developer/# for more information.
    1.  Add the access token to the hashbubble.config file and save it.

### Mapreduce guide

1.  In order to run the mapreduce functions the advanced.config file needs to be placed in the same folder as             riak.conf, e.g. dev/dev*/etc/advanced.config. The file needs to be edited so that the path points to the location     of the map_reduce.beam file, e.g ~/hashbubble/Backend/ebin/. 
    Important: each node must be restarted when changes are made to the map_reduce.erl file or the advanced.config        file.

        $ bin/riak-admin erl-reload

1.  Run the backend

    Run the Erlang shell from the repo's BackEnd directory with additional library path and configuration flags

        $ erl -pa deps/*/ebin -pa ebin -config hashbubble


    Now you are ready to run the project.

    ```erlang
    2> hb_supervisor:start().
    ```

    If you get no errors, your tweets should be saved in the `<"twitter_data">` bucket and instagram in the `<"instagram_data">` bucket in your Riak database.
### Frontend guide

1.  The contents of the frontend folder should be moved to the appropriate location, e.g. /var/www/html/. 
  
1.  The project makes use of the riak php client; this should be cloned into the same folder as the index.php file.

        $ git clone git://github.com/basho/riak-php-client.git

1.  Ubuntu LAMP users should ensure that they have php-curl installed.

        $ sudo apt-get install php5-curl

1.  The Apache web server then needs to be restarted.

        $ sudo service apache2 restart


## Dependencies

### [erlang-oauth](https://github.com/tim/erlang-oauth/)

erlang-oauth is used to construct signed request parameters required by OAuth.

### [ibrowse](https://github.com/cmullaparthi/ibrowse)

ibrowse is an HTTP client allowing to close a connection while the request is still being serviced. We need this for cancelling Twitter streaming API requests.

### [jiffy](https://github.com/davisp/jiffy)

jiffy is a JSON parser, which uses efficient C code to perform the actual parsing. [mochijson2](https://github.com/bjnortier/mochijson2) is another alternative that could be used here.

### [riakc](https://github.com/basho/riak-erlang-client)

riak-erlang-client is the library that we use to connect to Riak over the protocol buffers interface.



