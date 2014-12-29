#!/bin/bash
#
# This script shows how to implement a copy_to field that copies string to integer
#
curl -XDELETE localhost:9200/test-idx
echo
curl -XPUT localhost:9200/test-idx -d '{
    "settings": {
        "index": {
            "number_of_shards": 1,
            "number_of_replicas": 0
        }
    },
    "mappings": {
        "doc": {
            "properties": {
                "foo" : {
                    "type": "string",
                    "copy_to": "foo_int"
                },
                "foo_int": {
                    "type": "integer"
                }
            }
        }
    }
}'
echo
curl -XPUT localhost:9200/test-idx/doc/2 -d '{
    "foo": 42
}'
echo
curl -XPOST localhost:9200/test-idx/_refresh
echo
curl "localhost:9200/test-idx/doc/_mapping?pretty"
echo
curl "localhost:9200/test-idx/doc/_search?pretty" -d '{
    "query": {
        "range": {
            "foo_int": {
                "lt": 50,
                "gt": 40
            }
        }
    }
}'

