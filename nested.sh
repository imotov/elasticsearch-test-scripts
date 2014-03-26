#!/bin/bash
#
# This script demonstrates how to perform nested queries
#
curl -XDELETE localhost:9200/test-idx
curl -XPUT localhost:9200/test-idx -d '{
    "settings": {
        "index.number_of_shards": 1,
        "index.number_of_replicas": 0
    },
    "mappings": {
	    "type1" : {
	        "properties" : {
	            "obj1" : {
	                "type" : "nested",
	                "properties": {
	                    "name" : {"type": "string", "index": "not_analyzed"},
	                    "count" : {"type": "integer"}
	                }
	            }
	        }
	    }
    }
}'
curl -XPUT "localhost:9200/test-idx/type1/1" -d '{
    "obj1" : [
        {
            "name" : "blue",
            "count" : 4
        },
        {
            "name" : "green",
            "count" : 6
        }
    ]
}'
echo
curl -XPUT "localhost:9200/test-idx/type1/2" -d '{
    "obj1" : [
        {
            "name" : "blue",
            "count" : 6
        },
        {
            "name" : "green",
            "count" : 4
        }
    ]
}'
echo
curl -XPOST "localhost:9200/test-idx/_refresh"
echo
curl "localhost:9200/test-idx/type1/_search?pretty=true" -d '{
    "query": {
        "nested" : {
            "path" : "obj1",
            "score_mode" : "avg",
            "query" : {
                "bool" : {
                    "must" : [
                        {
                            "term" : {"obj1.name" : "blue"}
                        },
                        {
                            "range" : {"obj1.count" : {"gt" : 5}}
                        }
                    ]
                }
            }
        }
    }
}'
