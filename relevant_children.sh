#!/bin/bash
#
# This script demonstrates how to pass custom score value from child object to parent object
#
curl -XDELETE localhost:9200/test-idx
curl -XPUT localhost:9200/test-idx -d '{
    "settings": {
        "index.number_of_shards": 1,
        "index.number_of_replicas": 0
    },
    "mappings": {
        "doc": {
            "properties": {
                "name": {"type": "string"}
            }
        },
        "score": {
            "_parent": {
                "type": "doc"
            },
            "properties": {
                "point_type": {"type": "string", "index": "not_analyzed"},
                "points": {"type": "integer"}
            }
        }
    }
}'
curl -XPUT "localhost:9200/test-idx/doc/1" -d '{"name": "doc_1"}'
curl -XPUT "localhost:9200/test-idx/score/1-1?parent=1" -d '{"point_type": "odd", "points": 5}'
curl -XPUT "localhost:9200/test-idx/score/1-2?parent=1" -d '{"point_type": "odd", "points": 3}'
curl -XPUT "localhost:9200/test-idx/score/1-3?parent=1" -d '{"point_type": "even", "points": 8}'
curl -XPUT "localhost:9200/test-idx/doc/2" -d '{"name": "doc_2"}'
curl -XPUT "localhost:9200/test-idx/score/2-1?parent=2" -d '{"point_type": "odd", "points": 7}'
curl -XPUT "localhost:9200/test-idx/score/2-2?parent=2" -d '{"point_type": "even", "points": 6}'
curl -XPUT "localhost:9200/test-idx/score/2-3?parent=2" -d '{"point_type": "even", "points": 4}'
curl -XPOST localhost:9200/_refresh
echo
# Note: we have to specify fully qualified name (score.points) in the script as a workaround for this TODO:
# https://github.com/elasticsearch/elasticsearch/blob/3cd54fc4ee70a395e26dc5220e8245a55e2723aa/src/main/java/org/elasticsearch/index/query/HasChildQueryParser.java#L68
curl "localhost:9200/test-idx/doc/_search?pretty=true" -d '{
    "query": {
        "has_child": {
            "type": "score",
            "score_type" : "sum",
            "query" : {
                "custom_score": {
                    "script": "doc[\"score.points\"].value * 10",
                    "query": {
                        "term" : {
                            "point_type" : "odd"
                        }
                    }
                }
            }
        }
    }
}'