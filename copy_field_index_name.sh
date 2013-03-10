#!/bin/bash
#
# This script shows how to implement a copy_field-like functionality in elasticsearch
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
                "first_name": {
                    "type": "multi_field",
                    "path": "just_name",
                    "fields": {
                        "first_name": {"type": "string", "index": "analyzed"},
                        "copy": {"type": "string", "index": "analyzed", "index_name": "name"}
                    }
                },
                "last_name": {
                    "type": "multi_field",
                    "path": "just_name",
                    "fields": {
                        "last_name": {"type": "string", "index": "analyzed"},
                        "copy": {"type": "string", "index": "analyzed", "index_name": "name"}
                    }
                }
            }
        }
    }
}'
echo
curl -XPUT localhost:9200/test-idx/doc/1 -d '{
    "first_name": "Shay",
    "last_name": "Banon"
}'
echo
curl -XPOST localhost:9200/test-idx/_refresh
echo
curl "localhost:9200/test-idx/doc/_search?q=name:Shay"
echo
curl "localhost:9200/test-idx/doc/_search?q=name:Banon"
