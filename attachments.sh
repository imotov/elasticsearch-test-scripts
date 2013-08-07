#!/bin/bash
#
# This script demonstrates how to index attachments with custom analyzer
#
# It requires elasticsearch-mapper-attachments and elasticsearch-analysis-morphology 
# plugins to be installed on elasticsearch
#
curl -XDELETE localhost:9200/test-idx
curl -XPUT localhost:9200/test-idx -d '{
    "settings": {
        "index": {
            "number_of_shards": 1,
            "number_of_replicas": 0,
            "analysis": {
                "analyzer": {
                    "my_analyzer": {
                    "type": "custom",
                    "tokenizer": "standard",
                    "filter": ["lowercase", "english_morphology"]
                    }
                }
            }
        }
    },
    "mappings": {
        "doc": {
            "properties": {
                "my_data" : { 
                    "type" : "attachment",
                    "analyzer": "snowball",
                    "fields" : {
                        "my_data": {"analyzer": "my_analyzer"},
                        "file" : {"store": "yes", "analyzer": "standard"},
                        "date" : {"store": "yes"},
                        "author" : {"store" : "yes"}
                    }
                }
            }
        }
    }
}'
curl -XPUT "localhost:9200/test-idx/doc/1" -d "{
    \"my_data\" : \"`base64 test.pdf`\"
}"
echo
curl -XPOST "localhost:9200/test-idx/_refresh"
echo
curl "localhost:9200/test-idx/doc/_search?search_type=count&pretty=true" -d '{
    "query": {
        "match_all" : { }
    },
    "facets": {
        "words": {
            "terms": {
                "field": "my_data"
            }
        }
    }
}'
