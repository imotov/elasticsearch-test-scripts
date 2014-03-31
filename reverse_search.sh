#!/bin/bash
#
# Example of using reverse filter with ngrams
#
curl -XDELETE localhost:9200/reverse_test
curl -XPUT localhost:9200/reverse_test -d '{
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
                        "filter": ["standard", "lowercase", "reverse", "index_ngram", "reverse"]
                    },
                    "ngram_search": {
                        "tokenizer": "standard",
                        "filter": ["standard", "lowercase"]
                    }
                },
                "filter": {
                    "index_ngram": {
                        "type": "edgeNGram",
                        "min_gram": 1,
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
                    "type": "string",
                    "fields": {
                        "ngram" : {"type": "string", "index_analyzer": "ngram_index", "search_analyzer": "ngram_search"}
                    }
                },
                "phone": {
                    "type": "string",
                    "fields": {
                        "ngram" : {"type": "string", "index_analyzer": "ngram_index", "search_analyzer": "ngram_search"}
                    }
                }
            }
        }
    }
}'
echo
curl -XPUT localhost:9200/reverse_test/doc/1 -d '{"name": "John Smith", "phone": "5551234567"}'
echo
curl -XPUT localhost:9200/reverse_test/doc/2 -d '{"name": "John Doe", "phone": "5557778888"}'
echo
curl -XPUT localhost:9200/reverse_test/doc/3 -d '{"name": "Greg Smith", "phone": "5551113333"}'
echo
curl -XPOST localhost:9200/reverse_test/_refresh
echo
curl "localhost:9200/reverse_test/doc/_search?pretty=true" -d '{
    "query": {
		"match_phrase_prefix" : {
			 "phone.ngram" : {
				 "query": "123"
			 }
		 }    
	 }
}
'
curl "localhost:9200/reverse_test/doc/_search?pretty=true" -d '{
    "query": {
		"match_phrase_prefix" : {
			 "name.ngram" : {
				 "query": "oh"
			 }
		 }    
	 }
}
'
echo
# curl -XPOST "localhost:9200/reverse_test/_analyze?pretty&analyzer=ngram_index" -d "5551234567"

