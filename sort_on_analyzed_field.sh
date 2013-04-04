#!/bin/bash
#
# This script demonstrates how to sort on analyzed field
#
curl -XDELETE localhost:9200/test-idx
curl -XPUT localhost:9200/test-idx -d '{
    "settings": {
        "index": {
            "number_of_shards": 1,
            "number_of_replicas": 0
        },
        "analysis": {
            "analyzer": {
                "my_index_analyzer": {
                    "tokenizer": "standard",
                    "filter": ["standard", "lowercase", "snowball"]
                },
                "my_sort_analyzer": {
                    "tokenizer": "keyword",
                    "filter": ["lowercase"]
                }
            }
        }
    },
    "mappings": {
        "doc": {
            "properties": {
                "name": {
                    "type": "multi_field",
                    "fields": {
                        "name": {"type": "string", "index": "analyzed", "analyzer": "my_index_analyzer"},
                        "sort": {"type": "string", "index": "analyzed", "analyzer": "my_sort_analyzer"}
                    }
                }
            }
        }
    }
}
'
curl -XPUT localhost:9200/test-idx/doc/1 -d '{
    "name": "The Hitchhiker'\''s Guide to the Galaxy"
}'
curl -XPUT localhost:9200/test-idx/doc/2 -d '{
    "name": "The Restaurant at the End of the Universe"
}'
curl -XPUT localhost:9200/test-idx/doc/3 -d '{
    "name": "Life, the Universe and Everything"
}'
curl -XPUT localhost:9200/test-idx/doc/4 -d '{
    "name": "So Long, and Thanks for All the Fish"
}'
curl -XPUT localhost:9200/test-idx/doc/5 -d '{
    "name": "Mostly Harmless"
}'
curl -XPUT localhost:9200/test-idx/doc/6 -d '{
    "name": "And Another Thing..."
}'
curl -XPOST localhost:9200/test-idx/_refresh
echo
curl "localhost:9200/test-idx/_search?pretty=true" -d '{
    "query": {
        "match" : {
            "name" : "the things"
        }
    },
    "fields": "name",
    "sort": [
        {"name.sort": "asc"}
    ]
}
'
echo
