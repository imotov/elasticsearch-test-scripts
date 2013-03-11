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
curl -XPUT localhost:9200/test/doc/1 -d '{"foo": "bar"}'
curl -XPOST localhost:9200/test/_refresh
echo
curl "localhost:9200/test/doc/_search" -d '{
    "script_fields": {
        "test": {
            "script": "org.elasticsearch.common.logging.Loggers.getLogger(\"my_logger\").info(\"here comes a script\"); 42"
        }
    }
}'
echo
