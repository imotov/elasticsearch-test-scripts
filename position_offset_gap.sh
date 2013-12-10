curl -XDELETE localhost:9200/test-idx
curl -XPUT localhost:9200/test-idx -d '{
    "settings" :{
        "index": {
            "number_of_shards": 1,
            "number_of_replicas": 0
        }
    },
    "mappings": {
        "doc": {
            "properties": {
                "zero_gap" : {
                    "type": "string"
                },
                "non_zero_gap" : {
                    "type": "string",
                    "position_offset_gap": 256
                }
            }
        }
    }
}'
echo
curl -XPUT localhost:9200/test-idx/doc/1 -d '{
    "zero_gap": ["foo", "bar"],
    "non_zero_gap": ["foo", "bar"]
}'
echo
curl -XPOST localhost:9200/test-idx/_refresh
echo
curl "localhost:9200/test-idx/doc/_search?pretty=true" -d '{
    "query": {
        "match_phrase" : {
            "zero_gap" : "foo bar"
        }
    }
}'
echo
curl "localhost:9200/test-idx/doc/_search?pretty=true" -d '{
    "query": {
        "match_phrase" : {
            "non_zero_gap" : "foo bar"
        }
    }
}'