#!/bin/bash
#
# This script demonstrates usage of multi_field with mutli_match
#
curl -XDELETE localhost:9200/test-idx
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
                "model": { "type": "string", "index": "not_analyzed" }
            }
        }
    }
}
'
curl -XPUT localhost:9200/test-idx/doc/1 -d '{
    "model": "FTLX8571D3BCV-ITm"
}'
curl -XPOST localhost:9200/test-idx/_refresh
echo
curl "localhost:9200/test-idx/_search?pretty=true" -d '{
    "query": {
        "constant_score": {
            "filter": {
                "term": {
                    "model": "FTLX8571D3BCV-ITm"
                }
            }
        }
    }
}
'

