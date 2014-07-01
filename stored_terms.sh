#!/bin/bash
#
# This script demonstrates usage of stored terms and cache invalidation
#
curl -XDELETE "localhost:9200/test-idx?pretty"
curl -XDELETE "localhost:9200/test-idx-lookup?pretty"
curl -XPUT "localhost:9200/test-idx?pretty" -d '{
    "settings": {
        "index": {
            "number_of_shards": 1,
            "number_of_replicas": 0
        }
    },
    "mappings": {
        "doc": {
            "properties": {
                "foo": {
                    "type": "string",
                    "index": "not_analyzed"
                }
            }
        }
    }
}'
curl -XPOST "localhost:9200/test-idx/doc?pretty" -d '{"foo": "AAA"}'
curl -XPOST "localhost:9200/test-idx/doc?pretty" -d '{"foo": "BBB"}'
curl -XPOST "localhost:9200/test-idx/doc?pretty" -d '{"foo": "CCC"}'
curl -XPOST "localhost:9200/test-idx/doc?pretty" -d '{"foo": "DDD"}'
curl -XPOST "localhost:9200/test-idx/doc?pretty" -d '{"foo": "EEE"}'
curl -XPOST "localhost:9200/test-idx/doc?pretty" -d '{"foo": "FFF"}'
curl -XPOST "localhost:9200/test-idx-lookup/terms/1?pretty" -d '{
    "list": ["AAA", "DDD"]
}'
curl -XPOST "localhost:9200/_refresh?pretty"
curl -XPOST 'localhost:9200/test-idx/_cache/clear?filter_keys=list_1&pretty'
curl "localhost:9200/test-idx/doc/_search?pretty" -d '{
    "query": {
        "filtered": {
            "filter": {
                "terms": {
                    "foo": {
                        "index": "test-idx-lookup",
                        "type": "terms",
                        "id": "1",
                        "path": "list"
                    },
                    "_cache_key": "list_1"
                }
            }
        }
    }
}'
curl -XPOST "localhost:9200/test-idx-lookup/terms/1?pretty" -d '{
    "list": ["AAA", "DDD", "EEE"]
}'
curl -XPOST "localhost:9200/_refresh?pretty"
curl -XPOST 'localhost:9200/test-idx/_cache/clear?filter_keys=list_1&pretty'
curl "localhost:9200/test-idx/doc/_search?pretty" -d '{
    "query": {
        "filtered": {
            "filter": {
                "terms": {
                    "foo": {
                        "index": "test-idx-lookup",
                        "type": "terms",
                        "id": "1",
                        "path": "list"
                    },
                    "_cache_key": "list_1"
                }
            }
        }
    }
}'
