#!/bin/bash
# Example of returning parts of the string
# Should be used in conjuntion with substr.mvel script that should be moved to config/scripts
#

curl -XDELETE "http://localhost:9200/test-idx?pretty"
curl -XPUT "http://localhost:9200/test-idx/doc/1?pretty&refresh" -d '{
    "text": "This is a very large text string that has to be split in multiple parts!"
}'
curl -XGET "http://localhost:9200/test-idx/doc/_search?pretty" -d '{
    "script_fields": {
        "sub_test": {
            "script": "substr",
            "params": {
                "field": "text",
                "offset": 0,
                "len": 10
            }
        }
    }
}'
curl -XGET "http://localhost:9200/test-idx/doc/_search?pretty" -d '{
    "script_fields": {
        "sub_test": {
            "script": "substr",
            "params": {
                "field": "text",
                "offset": 70,
                "len": 10
            }
        }
    }
}'
