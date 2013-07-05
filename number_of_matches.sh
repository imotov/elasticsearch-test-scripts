#!/bin/bash
#
# This script demonstrates how to calculate number of matched term in the query
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
                "name": {"type": "string"}
            }
        }
    }
}'
curl -XPUT "localhost:9200/test-idx/doc/1" -d '{"name": "foo bar baz"}'
curl -XPUT "localhost:9200/test-idx/doc/2" -d '{"name": "foo abc xyz"}'
curl -XPUT "localhost:9200/test-idx/doc/3" -d '{"name": "bar baz"}'
curl -XPUT "localhost:9200/test-idx/doc/4" -d '{"name": "abc xyz"}'
curl -XPOST localhost:9200/_refresh
echo
curl "localhost:9200/test-idx/doc/_search?pretty=true" -d '{
    "explain": false,
    "query": {
        "custom_filters_score": {
            "query": {
                "constant_score" : {
                    "query": {
                        "bool": {
                            "should": [{
                                "match": {"name": "foo"}
                            },{
                                "match": {"name": "bar"}
                            },{
                                "match": {"name": "baz"}
                            }]
                        }
                    }
                }
            },
            "filters": [{
                "filter" : { "query" : { "match": {"name": "foo"}  } },
                "boost" : "1"
            },
            {
                "filter" : { "query" : { "match": {"name": "bar"}  } },
                "boost" : "1"
            },
            {
                "filter" : { "query" : { "match": {"name": "baz"}  } },
                "boost" : "1"
            }],
            "score_mode": "total"
        }
    }
}'
