#!/bin/bash
#
# Simple example of using script field with multiple values
#

curl -XDELETE localhost:9200/test
curl -XPUT localhost:9200/test -d '{
    "settings": {
        "index.number_of_shards": 1,
        "index.number_of_replicas": 0
    },
    "mappings": {
        "doc": {
            "_source": {"enabled": true},
            "properties": {
                "stored" : {"type": "string", "store" : "yes"},
                "sourced" : {"type": "string"}
            }
        }
    }
}'
curl -XPUT localhost:9200/test/doc/1 -d '{"stored": ["FOO", "BAR", "BAZ"], "sourced": ["ABC", "DEF", "GHI"]}'
curl -XPOST localhost:9200/test/_refresh
echo
curl "localhost:9200/test/doc/_search?pretty=true" -d '{
    "script_fields": {
        "stored_field_value": {
            "script": "_fields[\"stored\"].value"
        },
        "stored_field_values": {
            "script": "_fields[\"stored\"].values"
        },
        "stored_doc_values": {
            "script": "doc[\"stored\"].values"
        },
        "stored_doc_value": {
            "script": "doc[\"stored\"].value"
        },
        "from_source": {
            "script": "_source[\"sourced\"]"
        }
    }
}'
echo
