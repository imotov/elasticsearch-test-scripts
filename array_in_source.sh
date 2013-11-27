curl -XDELETE 'localhost:9200/test-idx?pretty'
curl -XPUT 'localhost:9200/test-idx?pretty' -d '{
    "settings": {
        "number_of_replicas": 0
    },
    "mappings": {
        "doc": {
            "properties": {
                "my_field": {
                    "type": "string",
                    "store": "no"
                }
            }
        }
    }
}'
curl -XPUT 'localhost:9200/test-idx/doc/1?pretty' -d '{"my_field": ["bar", "baz"]}'
curl -XPUT 'localhost:9200/test-idx/doc/2?pretty' -d '{"my_field": ["bar"]}'
curl -XPUT 'localhost:9200/test-idx/doc/3?pretty' -d '{"my_field": "foo"}'
curl -XPOST 'localhost:9200/test-idx/_refresh?pretty'
curl -XPOST 'localhost:9200/test-idx/_flush?pretty'
curl -XGET 'localhost:9200/test-idx/_search?pretty' -d '{
    "fields": ["my_field"],
    "sort": "_uid"
}'
