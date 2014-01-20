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
            "dynamic_templates" : [{
                "template_1" : {
                    "match" : "*_raw",
                    "match_mapping_type" : "string",
                    "mapping" : {
                        "type" : "string",
                        "index" : "not_analyzed"
                    }
                }
            }, {
                "template_2" : {
                    "match" : "*",
                    "match_mapping_type" : "string",
                    "mapping" : {
                        "type" : "string",
                        "copy_to": "{name}_raw"
                    }
                }
            }]
        }
    }
}'
echo
curl -XPUT localhost:9200/test-idx/doc/2 -d '{
    "test2": "Clinton Gormley"
}'
echo
curl -XPOST localhost:9200/test-idx/_refresh
echo
curl "localhost:9200/test-idx/doc/_mapping?pretty"
echo
curl "localhost:9200/test-idx/doc/_search?pretty" -d '{
    "facets": {
        "facet_test": {
            "terms": {
                "field": "test2_raw"
            }
        }
    }
}'

