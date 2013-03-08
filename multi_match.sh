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
                "subject": {
                    "type": "multi_field",
                    "fields": {
                        "fulltext": { "type": "string", "index": "analyzed" },
                        "subject": { "type": "string", "index": "not_analyzed" }
                    }
                },
                "message": {
                    "type": "multi_field",
                    "fields": {
                        "fulltext": { "type": "string", "index": "analyzed" },
                        "message": { "type": "string", "index": "not_analyzed" }
                    }
                }
            }
        }
    }
}
'
curl -XPUT localhost:9200/test-idx/doc/1 -d '{
    "subject": "elasticsearch",
    "message": "You know, for search"
}'
curl -XPUT localhost:9200/test-idx/doc/2 -d '{
    "subject": "The Hudsucker Proxy",
    "message": "You know, for kids"
}'
curl -XPOST localhost:9200/test-idx/_refresh
echo
curl "localhost:9200/test-idx/_search?pretty=true" -d '{
    "query": {
        "multi_match" : {
            "query" : "know",
            "fields" : [ "*.fulltext"]
        }
    }
}
'
echo
curl "localhost:9200/test-idx/_validate/query?pretty=true&explain=true" -d '{
        "multi_match" : {
            "query" : "know",
            "fields" : [ "*.fulltext"]
        }
}
'

