#!/bin/bash
#
# This script shows how to use indices filter to search several indices with different filters in the same request
#

# Recreate both indices
curl -s -XDELETE "localhost:9200/foo-idx,bar-idx?pretty"
curl -s -XPUT "localhost:9200/foo-idx?pretty" -d '{
    "settings": {
        "number_of_shards": 1,
        "number_of_replicas": 0
    }
}'
curl -s -XPUT "localhost:9200/bar-idx?pretty" -d '{
    "settings": {
        "number_of_shards": 1,
        "number_of_replicas": 0
    }
}'

# Index some test data
curl -s -XPUT "localhost:9200/bar-idx/doc/1?pretty" -d '{
    "name": "foo"
}'
curl -s -XPUT "localhost:9200/bar-idx/doc/2?pretty" -d '{
    "name": "bar"
}'
curl -s -XPUT "localhost:9200/foo-idx/doc/1?pretty" -d '{
    "name": "foo"
}'
curl -s -XPUT "localhost:9200/foo-idx/doc/2?pretty" -d '{
    "name": "bar"
}'
curl -s -XPOST "localhost:9200/_refresh"

# Search for "foo" in the "foo-idx" and "bar" in the "bar-idx"
curl -s -XPOST "localhost:9200/foo-idx,bar-idx/_search?pretty" -d '{
    "query": {
        "constant_score": {
            "filter": {
                "bool": {
                    "should": [{
                        "indices": {
                            "indices": ["foo-idx"],
                            "filter": {
                                "term": {
                                    "name": "foo"
                                }
                            },
                            "no_match_filter" : "none"
                        }
                    }, {
                        "indices": {
                            "indices": ["bar-idx"],
                            "filter": {
                                "term": {
                                    "name": "bar"
                                }
                            },
                            "no_match_filter" : "none"
                        }
                    }]
                }
            }
        }
    }

}'