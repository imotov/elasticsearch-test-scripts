#!/bin/bash
#
# Demonstrates the use of _ttl
#

#
# Change the ttl interval on the cluster to make this example to run faster 
# **** THIS IS CLUSTER-WIDE SETTING. DON'T USE IN PRODUCTION ****
#
curl -XPUT localhost:9200/_cluster/settings -d '{
    "transient": {
        "indices.ttl.interval": "1s"
    }
}'
echo
curl -XDELETE localhost:9200/test
echo
curl -XPUT localhost:9200/test -d '{
    "settings": {
        "index.number_of_shards": 1,
        "index.number_of_replicas": 0
    },
    "mappings": {
        "doc": {
            "_ttl" : { "enabled" : true },
            "properties": {
                "title": { "type": "string" }
            }
        }
    }
}'
curl -XPUT localhost:9200/test/doc/1 -d '{"title": "never expire"}'
curl -XPUT localhost:9200/test/doc/2 -d '{"title": "expire in 5 sec", "_ttl": "5s"}'
curl -XPUT localhost:9200/test/doc/3 -d '{"title": "expire in 15 sec", "_ttl": "15s"}'
echo
curl -XPOST localhost:9200/test/_refresh
echo
echo "Search should return all"
curl -XGET "localhost:9200/test/_search?pretty=true"
echo
echo "Sleeping 6 sec"
sleep 6
echo "Search should return 2 records"
curl -XGET "localhost:9200/test/_search?pretty=true"
echo
echo "Sleeping 10 sec"
sleep 10
echo "Search should return 1 record"
curl -XGET "localhost:9200/test/_search?pretty=true"

