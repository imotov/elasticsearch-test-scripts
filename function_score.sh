curl -XDELETE "localhost:9200/test-idx"
echo
curl -XPUT "localhost:9200/test-idx" -d '{
    "settings": {
        "index.number_of_replicas": 0,
        "index.number_of_shards": 1
    },
    "mapping": {
        "doc": {
            "name": {"type": "string", "index": "not_analyzed"},
            "subject": {"type": "string", "index": "not_analyzed"},
            "subject_score": {"type": "int"}
        }
    }
}' 
echo
curl -XPUT "localhost:9200/test-idx/doc/1" -d '{
    "name": "user1234",
    "subject": "math",
    "subject_score": 100
}'
echo
curl -XPUT "localhost:9200/test-idx/doc/2" -d '{
    "name": "user1234",
    "subject": "physics",
    "subject_score": 200
}'
curl -XPOST "localhost:9200/test-idx/_refresh"
echo
echo
echo "custom_filters_score version"
curl -XGET "localhost:9200/test-idx/doc/_search?pretty&fields=" -d '{
    "query": {
        "custom_filters_score": {
            "query": {
                "term": {
                    "name": "user1234"
                }
            },
            "filters": [{
                "filter": {
                    "term": {
                        "subject": "math"
                    }
                },
                "script": "_score > 0.0 ? (_score + doc[\"subject_score\"].value) / _score : 0.0"
            }],
            "score_mode": "first"
        }
    }
}'
echo
echo "custom_score version"
curl -XGET "localhost:9200/test-idx/doc/_search?pretty&fields=" -d '{
    "query": {
        "custom_score": {
            "query": {
                "custom_filters_score": {
                    "query": {
                        "term": {
                            "name": "user1234"
                        }
                    },
                    "filters": [{
                        "filter": {
                            "term": {
                                "subject": "math"
                            }
                        },
                        "script": "-1.0"
                    }]
                }
            },
            "script": "_score < 0.0 ? _score * -1.0 + doc[\"subject_score\"].value : _score"
        }
    }
}'
echo
echo "function_score - 1"
curl -XGET "localhost:9200/test-idx/doc/_search?pretty&fields=" -d '{
    "query": {
        "function_score": {
            "query": {
                "term": {
                    "name": "user1234"
                }
            },
            "functions": [{
                "filter": {
                    "term": {
                        "subject": "math"
                    }
                },
                "script_score": {
                    "script": "_score + doc[\"subject_score\"].value"
                }
            }, {
                "script_score": {
                    "script": "_score"
                }
            
            }],
            "score_mode": "first",
            "boost_mode": "replace"
        }
    }
}'
echo
echo "function_score - 2"
    curl -XGET "localhost:9200/test-idx/doc/_search?pretty&fields=" -d '{
        "query": {
            "function_score": {
                "query": {
                    "term": {
                        "name": "user1234"
                    }
                },
                "functions": [{
                    "filter": {
                        "term": {
                            "subject": "math"
                        }
                    },
                    "script_score": {
                        "script": "doc[\"subject_score\"].value"
                    }
                }, {
                    "boost_factor": 0
            
                }],
                "score_mode": "first",
                "boost_mode": "sum"
            }
        }
    }'