# Create test index
curl -XDELETE 'http://localhost:9200/test-idx?pretty'
curl -XPUT 'http://localhost:9200/test-idx?pretty' -d '{
    "settings": {
        "index.number_of_shards": 3,
        "index.number_of_replicas": 0
    }
}'
for i in {1..100} 
do
    curl -XPUT "http://localhost:9200/test-idx/doc/$i" -d "{\"foo\": \"bar $i\"}"
done
curl -XPOST "http://localhost:9200/test-idx/_flush"


# Create really slow backup so we can check status
curl -XDELETE 'http://localhost:9200/_snapshot/my_backup?pretty'
rm -r /tmp/my_backup
curl -XPUT 'http://localhost:9200/_snapshot/my_backup?pretty' -d '{
    "type": "fs",
    "settings": {
        "location": "/tmp/my_backup",
        "max_snapshot_bytes_per_sec": "50"
    }
}'
#Snapshot and display status
curl -XPUT "localhost:9200/_snapshot/my_backup/snapshot_1?pretty" -d '{
    "indices": "test-idx",
    "ignore_unavailable": "true",
    "include_global_state": false
}'
for i in {1..15} 
do
    echo $i
    curl -XGET "localhost:9200/_snapshot/my_backup/snapshot_1/_status?pretty"
    # curl -XGET "localhost:9200/_snapshot/my_backup/snapshot_1?pretty"
    sleep 1
done
