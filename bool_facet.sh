#!/bin/bash
#
# This script shows how to run facets on boolean fields
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
            "foo": {
                "type": "boolean"
            }
        }
    }
}'
echo
curl -XPOST localhost:9200/test-idx/doc -d '{
    "foo": true
}'
echo
curl -XPOST localhost:9200/test-idx/doc -d '{
    "foo": true
}'
echo
curl -XPOST localhost:9200/test-idx/doc -d '{
    "foo": false
}'
echo
curl -XPOST localhost:9200/test-idx/doc -d '{
    "foo": true
}'
echo
curl -XPOST localhost:9200/test-idx/doc -d '{
    "foo": false
}'
echo
curl -XPOST localhost:9200/test-idx/_refresh
echo
curl "localhost:9200/test-idx/doc/_search?pretty" -d '{
    "facets": {
        "facet_test": {
            "terms": {
                "field": "foo"
            }
        }
    }
}'

