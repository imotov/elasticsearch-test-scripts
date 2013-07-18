curl -XDELETE localhost:9200/test-idx
curl -XPUT localhost:9200/test-idx -d '{
    "settings": {
        "index": {
            "number_of_shards": 1,
            "number_of_replicas": 0,
            "analysis": {
                "analyzer": {
                    "synonym": {
                        "tokenizer": "standard",
                        "filter": ["lowercase","synonym"]
                    },
                    "not_synonym": {
                        "tokenizer": "standard",
                        "filter": ["lowercase"]
                    }
                },
                "filter": {
                    "synonym": {
                        "type": "synonym",
                        "synonyms": ["i_pod, i pod => ipod"]
                    }
                }
            }
        }
    },
    "mappings": {
        "doc": {
            "properties": {
                "name": {
                    "type": "multi_field",
                    "fields": {
                        "name": {
                            "type": "string",
                            "index": "analyzed",
                            "analyzer": "not_synonym"
                        },
                        "with_synonyms": {
                            "type": "string",
                            "index": "analyzed",
                            "analyzer": "synonym"
                        }
                    }
                }
            }
        }
    }
}
'

curl -XPUT localhost:9200/test-idx/doc/1 -d '{
    "name": "Testing i_pod"
}'
curl -XPUT localhost:9200/test-idx/doc/2 -d '{
    "name": "Testing i pod"
}'
curl -XPUT localhost:9200/test-idx/doc/3 -d '{
    "name": "Testing iPod"
}'
curl -XPOST localhost:9200/test-idx/_refresh
echo
echo "------------"
echo "Searching for i_pod"
curl "localhost:9200/test-idx/doc/_search?pretty=true" -d '{
    "query": {
        "multi_match" : {
            "query" : "i_pod",
            "operator": "AND",
            "fields" : [ "name", "name.with_synonyms^0.5" ]
        }
    },
    "fields": ["name"]
}'
echo
echo "Searching for i pod"
curl "localhost:9200/test-idx/doc/_search?pretty=true" -d '{
    "query": {
        "multi_match" : {
            "query" : "i pod",
            "operator": "AND",
            "fields" : [ "name", "name.with_synonyms^0.5" ]
        }
    }
}'
echo
echo "Searching for ipod"
curl "localhost:9200/test-idx/doc/_search?pretty=true" -d '{
    "query": {
        "multi_match" : {
            "query" : "ipod",
            "operator": "AND",
            "fields" : [ "name", "name.with_synonyms^0.5" ]
        }
    }
}'