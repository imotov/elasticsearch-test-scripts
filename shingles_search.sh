#!/bin/bash
#
# Example of using shingle for both searching and indexing
#
curl -XDELETE localhost:9200/shingles_test
curl -XPUT localhost:9200/shingles_test -d '{
    "settings": {
        "index": {
            "number_of_shards": 1,
            "number_of_replicas": 0,
            "analysis": {
                "analyzer": {
                    "default_index": {
                        "tokenizer": "standard",
                        "filter": ["standard", "lowercase", "index_shingle"]
                    },
                    "default_search": {
                        "tokenizer": "standard",
                        "filter": ["standard", "lowercase"]
                    },
                    "shingle_search": {
                        "tokenizer": "standard",
                        "filter": ["standard", "lowercase", "search_shingle"]
                    }
                },
                "filter": {
                    "index_shingle": {
                        "type": "shingle",
                        "min_shingle_size": 2,
                        "max_shingle_size": 2,
                        "output_unigrams": true,
                        "token_separator": ""
                    },
                    "search_shingle": {
                        "type": "shingle",
                        "min_shingle_size": 2,
                        "max_shingle_size": 2,
                        "output_unigrams": false,
                        "token_separator": ""
                    }
                }
            }
        }
    },
    "mappings": {
        "doc": {
            "message": {
                "type": "string"
            }
        }
    }
}'
echo
curl -XPUT localhost:9200/shingles_test/doc/1 -d '{"message": "foo bar baz"}'
echo
curl -XPUT localhost:9200/shingles_test/doc/2 -d '{"message": "foobar baz"}'
echo
curl -XPUT localhost:9200/shingles_test/doc/3 -d '{"message": "foo barbaz"}'
echo
curl -XPOST localhost:9200/shingles_test/_refresh
echo
curl "localhost:9200/shingles_test/doc/_search?pretty=true" -d '{
    "query": {
        "dis_max" : {
            "queries": [
                {
                    "match": {
                        "_all": {
                            "query": "foo bar",
                            "operator" : "and"
                        } 
                    }
                },
                {
                    "match": {
                        "_all": {
                            "query": "foo bar",
                            "operator" : "and",
                            "analyzer": "shingle_search"
                        } 
                    }
                }
            ]
        }
    }
}'
echo
curl "localhost:9200/shingles_test/doc/_search?pretty=true" -d '{
    "query": {
        "dis_max" : {
            "queries": [
                {
                    "match": {
                        "_all": {
                            "query": "foobar baz",
                            "operator" : "and"
                        } 
                    }
                },
                {
                    "match": {
                        "_all": {
                            "query": "foobar baz",
                            "operator" : "and",
                            "analyzer": "shingle_search"
                        } 
                    }
                }
            ]
        }
    }
}'
echo
curl "localhost:9200/shingles_test/doc/_search?pretty=true" -d '{
    "query": {
        "dis_max" : {
            "queries": [
                {
                    "match": {
                        "_all": {
                            "query": "bar baz",
                            "operator" : "and"
                        } 
                    }
                },
                {
                    "match": {
                        "_all": {
                            "query": "bar baz",
                            "operator" : "and",
                            "analyzer": "shingle_search"
                        } 
                    }
                }
            ]
        }
    }
}'
echo