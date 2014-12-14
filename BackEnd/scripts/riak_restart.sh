 #!/bin/bash  

for node in ~/otp_src_R16B02-basho5/riak-2.0.2/dev/dev*; do $node/bin/riak-admin erl-reload; done
