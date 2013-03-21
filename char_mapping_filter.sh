#!/bin/bash
#
# Demonstrate use of char mapping filter
#
curl -XDELETE 'http://localhost:9200/test-idx'
curl -XPUT 'http://localhost:9200/test-idx' -d '{
    "settings": {
        "index.number_of_shards": 1,
        "index.number_of_replicas": 0,
        "analysis": {
            "char_filter": {
                "my_mapping": {
                    "type": "mapping",
                    "mappings": ["ph=>f", "qu=>q", "_=>\\u0020"]
                }
            },
            "analyzer": {
                "custom_with_char_filter": {
                    "tokenizer": "standard",
                    "char_filter": ["my_mapping"]
                }
            }
        }
    }
}
'
echo
curl 'http://localhost:9200/_cluster/health/test?wait_for_status=green'
echo
TEXT="phishing_test"
echo
curl -XGET 'http://localhost:9200/test-idx/_analyze?analyzer=custom_with_char_filter&pretty=true' -d "$TEXT"
echo

