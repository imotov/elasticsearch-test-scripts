#!/bin/bash
#
# Demonstrate the effect of disabling indexing of the type field
#
curl -XDELETE 'http://localhost:9200/test-idx'
curl -XPUT 'http://localhost:9200/test-idx' -d '{
    "settings": {
        "index.number_of_shards": 1,
        "index.number_of_replicas": 0
    },
    "mappings": {
        "not_indexed_type": {
            "_type": {
                "index": "no"
            },
            "properties": {
                "message": {
                    "type": "string",
                    "store": "yes"
                }
            }
        },
        "indexed_type": {
            "properties": {
                "message": {
                    "type": "string",
                    "store": "yes"
                }
            }
        }
    }
}'
echo
curl -XGET 'http://localhost:9200/_cluster/health?wait_for_status=yellow'
echo
curl -XGET 'http://localhost:9200/test-idx/indexed_type/1' -d '{"message":"bar"}'
echo
curl -XGET 'http://localhost:9200/test-idx/not_indexed_type/2' -d '{"message":"bar"}'
echo
echo "---------------------------------------"
echo "Query expansion for non indexed type"
curl -XGET 'http://localhost:9200/test-idx/_validate/query?explain=true&q=not_indexed_type.message:bar&pretty=true'
echo
echo "---------------------------------------"
echo "Query expansion for indexed type"
curl -XGET 'http://localhost:9200/test-idx/not_indexed_type/_validate/query?explain=true&q=indexed_type.message:bar&pretty=true'
echo