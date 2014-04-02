#!/bin/bash
#
# This script demonstrates how to test different similarities for the same field
#
#
curl -XDELETE "localhost:9200/test-idx?pretty"
curl -XPUT "localhost:9200/test-idx?pretty" -d '{
	"settings": {
		"index": {
			"number_of_shards": 1,
			"number_of_replicas": 0,
			"similarity": {
				"my_bm25": {
					"type": "BM25"
				},
				"my_dfr": {
					"type": "DFR",
					"basic_model": "be",
					"after_effect": "no",
					"normalization": "no"
				},
				"my_ib": {
					"type": "IB",
					"distribution": "ll",
					"lambda": "df",
					"normalization": "no"
				}
			}
		}
	},
	"mappings": {
		"doc": {
			"properties": {
				"my_data": {
					"type": "string",
					"fields": {
						"bm25": {
							"type": "string",							
							"similarity": "my_bm25"
						},
						"dfr": {
							"type": "string",	
							"similarity": "my_dfr"
						},
						"ib": {
							"type": "string",	
							"similarity": "my_ib"
						}
					}
				}
			}
		}
	}
}'
curl -XPUT "localhost:9200/test-idx/doc/1?pretty" -d '{"my_data": "similiarity is awesome in this test"}'
curl -XPUT "localhost:9200/test-idx/doc/2?pretty" -d '{"my_data": "similiarity in this similiarity test"}'
curl -XPUT "localhost:9200/test-idx/doc/3?pretty" -d '{"my_data": "test it all the way in this test"}'
curl -XPOST "localhost:9200/test-idx/_refresh?pretty"
echo "Default simliarity"
curl "localhost:9200/test-idx/doc/_search?pretty=true" -d '{
    "query": {
        "match" : {
			"my_data": "similiarity test"
		}
    },
	"fields": ["my_data"]
}'
echo "BM25 simliarity"
curl "localhost:9200/test-idx/doc/_search?pretty=true" -d '{
    "query": {
        "match" : {
			"my_data.bm25": "similiarity test"
		}
    },
	"fields": ["my_data"]
}'
echo "DFR simliarity"
curl "localhost:9200/test-idx/doc/_search?pretty=true" -d '{
    "query": {
        "match" : {
			"my_data.dfr": "similiarity test"
		}
    },
	"fields": ["my_data"]
}'
echo "IB simliarity"
curl "localhost:9200/test-idx/doc/_search?pretty=true" -d '{
    "query": {
        "match" : {
			"my_data.ib": "similiarity test"
		}
    },
	"fields": ["my_data"]
}'
