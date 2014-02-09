#!/bin/bash
#
# This script demonstrates how to use field-level index time boost
#
curl -XDELETE localhost:9200/test-idx
curl -XPUT localhost:9200/test-idx -d '{
    "settings": {
        "index.number_of_shards": 1,
        "index.number_of_replicas": 0
    },
    "mappings": {
        "doc": {
            "properties": {
                "foo": {"type": "string", "boost": 10},
                "bar": {"type": "string"}
            }
        }
    }
}'
curl -XPUT "localhost:9200/test-idx/doc/1" -d '{"foo": "baz"}'
curl -XPUT "localhost:9200/test-idx/doc/2" -d '{"bar": "baz"}'
curl -XPOST localhost:9200/_refresh
echo
curl "localhost:9200/test-idx/doc/_search?pretty=true" -d '{
    "explain": false,
    "query": {
        "bool": {
            "should": [{
                "match": {"foo": "baz"}
            }, {
                "match": {"bar": "baz"}
            }]
        }

    }
}'
