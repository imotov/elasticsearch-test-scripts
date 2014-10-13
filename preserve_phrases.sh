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
                    }
                },
                "filter": {
                    "synonym": {
                        "type": "synonym",
                        "synonyms": ["fashion police => fashion$police", "double jeopardy => double$jeopardy"]
                    }
                }
            }
        }
    },
    "mappings": {
        "doc": {
            "properties": {
                "name": {
                    "type": "string",
                    "index": "analyzed",
                    "analyzer": "synonym"
                }
            }
        }
    }
}
'

curl -XPUT "localhost:9200/test-idx/doc/1?pretty" -d '{
    "name": "Police investigating possible double homicide"
}'
curl -XPUT "localhost:9200/test-idx/doc/2?pretty" -d '{
    "name": "Fashion Police is an American television series airing on E!."
}'
curl -XPUT "localhost:9200/test-idx/doc/3?pretty" -d '{
    "name": "Double Jeopardy!, the second round of the TV game show Jeopardy!"
}'
curl -XPOST "localhost:9200/test-idx/_refresh?pretty"
echo
echo "------------"
echo "Searching for Double"
curl "localhost:9200/test-idx/doc/_search?pretty=true" -d '{
    "query": {
        "match" : {
            "name" : "Double"
        }
    },
    "fields": ["name"]
}'
echo "Searching for Double Jeopardy"
curl "localhost:9200/test-idx/doc/_search?pretty=true" -d '{
    "query": {
        "match" : {
            "name" : "Double Jeopardy"
        }
    },
    "fields": ["name"]
}'
echo "Searching for police"
curl "localhost:9200/test-idx/doc/_search?pretty=true" -d '{
    "query": {
        "match" : {
            "name" : "police"
        }
    },
    "fields": ["name"]
}'
echo "Searching for fasion police"
curl "localhost:9200/test-idx/doc/_search?pretty=true" -d '{
    "query": {
        "match" : {
            "name" : "fashion police"
        }
    },
    "fields": ["name"]
}'
