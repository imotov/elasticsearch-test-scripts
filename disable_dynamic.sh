#!/bin/bash
#
# This script shows how to disable dynamic mapping on a part of the object
# See http://stackoverflow.com/questions/17595129/elasticsearch-index-only-part-of-the-object
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
                "record": {
                    "type": "object",
                    "properties": {
                        "city": {"type": "string"}
                    },
                    "dynamic": false
                }
            }
        }
    }
}'
echo
curl -XPUT localhost:9200/test-idx/doc/1 -d '{
    "record": {
        "city": "London",
        "contact": "Some person name"
    }
}'
echo
curl -XPUT localhost:9200/test-idx/doc/2 -d '{
    "record": {
        "city": "London",
        "contact": { "phone": "some-phone-number", "name": "Other person'\''s name" }
    },
    "foo": "bar"
}'
echo
curl -XPUT localhost:9200/test-idx/doc/3 -d '{
    "record": {
        "city": "Oslo",
        "headquarters": { "phone": "some-other-phone-number", "address": "some address" }
    }
}'
echo
curl -XPOST localhost:9200/test-idx/_refresh
echo
curl "localhost:9200/test-idx/doc/_search?q=city:London&pretty"
echo
curl "localhost:9200/test-idx/doc/_mapping?pretty"