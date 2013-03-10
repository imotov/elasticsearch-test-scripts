#!/bin/bash
#
# Simple example of sorting using script
#

curl -XDELETE localhost:9200/test
curl -XPUT localhost:9200/test -d '{
    "settings": {
        "index.number_of_shards": 1,
        "index.number_of_replicas": 0
    },
    "mappings": {
        "doc": {
            "_timestamp" : {"enabled" : true, "index" : "analyzed", "store" : "yes"}
        }
    }
}'
curl -XPUT localhost:9200/test/doc/1 -d '{"foo": ["1"]}'
curl -XPUT localhost:9200/test/doc/2 -d '{"foo": ["2", "3"]}'
curl -XPUT localhost:9200/test/doc/3 -d '{"foo": ["3", "4", "5"]}'
curl -XPOST localhost:9200/test/_refresh
echo
curl "localhost:9200/test/doc/_search" -d '{
    "sort": [
        {
            "_script": {
                "script" : "doc[\"foo\"].values.size()",
                "type" : "number"
            }
            
        }
    ]
}'
echo
