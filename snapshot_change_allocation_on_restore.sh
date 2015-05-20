#!/bin/bash
#
# Example of working changing shard allocation filtering on restore
# To use start two nodes on the locahost with the following command lines:
#  bin/elasticsearch --node.size=large  
#  bin/elasticsearch --node.size=small
#
ES_HOST="localhost:9200"
REPO_DIR="${TMPDIR}repo/`uuidgen`"
#REPO_DIR="/Volumes/TestDisk/`uuidgen`"
echo $REPO_DIR

# Create new repository
curl -s -XDELETE "http://$ES_HOST/_snapshot/my_backup?pretty"
curl -s -XPUT "http://$ES_HOST/_snapshot/my_backup?pretty" -d '{
    "type": "fs",
    "settings": {
        "location": "'$REPO_DIR'",
        "max_restore_bytes_per_sec": "1000",
        "compress": true
    }
}'

# Index some test data
curl -s -XDELETE "http://$ES_HOST/test-idx?pretty"
curl -s -XPUT "http://$ES_HOST/test-idx?pretty" -d '{
    "settings": {
        "index.number_of_shards": 3,
        "index.number_of_replicas": 0,
        "index.refresh_interval": -1,
		"index.routing.allocation.include.size": "small"
    }
}'

for i in {1..100} 
do
    curl -s -XPUT "http://$ES_HOST/test-idx/doc/$i" -d "{\"foo\": \"bar $i\"}"
done
curl -s -XPOST "http://$ES_HOST/test-idx/_refresh?pretty"

echo "Settings before restore"
curl -s -XGET "http://$ES_HOST/test-idx/_settings?pretty"

# Snapshot and display status
curl -s -XPUT "http://$ES_HOST/_snapshot/my_backup/snapshot_1?pretty&wait_for_completion=true" -d '{
    "indices": "test-idx",
    "include_global_state": false
}'

echo "Allocation before deletion of the index"
curl -s -XGET "http://$ES_HOST/_cat/shards/test-idx"

# Delete the index
curl -s -XDELETE "http://$ES_HOST/test-idx"

# Restore index while changing it's settings

curl -s -XPOST "http://$ES_HOST/_snapshot/my_backup/snapshot_1/_restore?pretty&wait_for_completion=false" -d '{
    "index_settings" : {
	    "index.routing.allocation.include.size": "large"
    },
    "ignore_index_settings": ["index.refresh_interval"],
    "include_global_state": false
}'

echo "Allocation during restore"
for i in {1..20}
do
	echo "--------------"
	curl -s -XGET "http://$ES_HOST/_cat/shards/test-idx"
	sleep 1
done
 