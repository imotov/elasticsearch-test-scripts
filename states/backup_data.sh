curl -XPUT 'http://localhost:9200/_snapshot/my_test_data?pretty' -d '{
    "type": "s3",
    "settings": {
        "base_path": "demo"
    }
}'
curl -XDELETE "localhost:9200/_snapshot/my_test_data/test?pretty"
curl -XPUT "localhost:9200/_snapshot/my_test_data/test?wait_for_completion=true&pretty" -d '{
    "indices": ["large_us_cities"],
    "include_global_state": false
}'