#!/bin/bash
#
# Example of using ngrams
#
curl -XDELETE localhost:9200/ngram_test
curl -XPUT localhost:9200/ngram_test -d '{
    "settings": {
        "index": {
            "number_of_shards": 1,
            "number_of_replicas": 0,
            "analysis": {
                "analyzer": {
                    "default_search": {
                        "tokenizer": "standard",
                        "filter": ["standard", "lowercase"]
                    },
                    "default_index": {
                        "tokenizer": "standard",
                        "filter": ["standard", "lowercase"]
                    },
                    "ngram_index": {
                        "tokenizer": "standard",
                        "filter": ["standard", "lowercase", "index_ngram"]
                    },
                    "ngram_search": {
                        "tokenizer": "standard",
                        "filter": ["standard", "lowercase"]
                    }
                },
                "filter": {
                    "index_ngram": {
                        "type": "nGram",
                        "min_gram": 3,
                        "max_gram": 50
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
                        "name" : {"type": "string"},
                        "ngram" : {"type": "string", "index_analyzer": "ngram_index", "search_analyzer": "ngram_search"}
                    }
                },
                "phone": {
                    "type": "multi_field",
                    "fields": {
                        "phone" : {"type": "string"},
                        "ngram" : {"type": "string", "index_analyzer": "ngram_index", "search_analyzer": "ngram_search"}
                    }
                }
            }
        }
    }
}'
echo
curl -XPUT localhost:9200/ngram_test/doc/1 -d '{"name": "John Smith", "phone": "5551234567"}'
echo
curl -XPUT localhost:9200/ngram_test/doc/2 -d '{"name": "John Doe", "phone": "5557778888"}'
echo
curl -XPUT localhost:9200/ngram_test/doc/3 -d '{"name": "Greg Smith", "phone": "5551113333"}'
echo
curl -XPOST localhost:9200/ngram_test/_refresh
echo
curl "localhost:9200/ngram_test/doc/_search?pretty=true" -d '{
    "query": {
        "multi_match": {
            "query": "John Smi 555 123",
            "fields": ["name^10", "phone^10", "name.ngram", "phone.ngram"]
        }
    }
}
'
echo
