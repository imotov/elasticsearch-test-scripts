#!/bin/bash
#
# Example of matching all values of a data field to a request
#
curl -XDELETE localhost:9200/test
curl -XPUT localhost:9200/test -d '{
    "settings": {
        "index.number_of_shards": 1,
        "index.number_of_replicas": 0
    },
    "mappings": {
        "doc": {
            "properties": {
                "controlled_fields": {
                    "type": "nested",
                    "properties": {
                        "controlled_field": {
                            "type": "string",
                            "index": "not_analyzed"
                        }
                    }
                }
            }
        }
    }
}
'
curl -XPOST localhost:9200/test/doc/1 -d '{
    "controlled_fields": [{
        "controlled_field": "A"
    }, {
        "controlled_field": "B"
    }, {
        "controlled_field": "C"
    }]
}

'
curl -XPOST localhost:9200/test/doc/2 -d '{
    "controlled_fields": [{
        "controlled_field": "X"
    }, {
        "controlled_field": "Y"
    }, {
        "controlled_field": "Z"
    }]
}
'
curl -XPOST localhost:9200/test/doc/3 -d '{
    "controlled_fields": [{
        "controlled_field": "A"
    }, {
        "controlled_field": "Y"
    }, {
        "controlled_field": "D"
    }]
}
'
curl -X POST 'http://localhost:9200/test/_refresh'
echo
curl -X GET 'http://localhost:9200/test/doc/_search?pretty' -d '{
    "query": {
        "filtered": {
            "query": {
                "match_all": {}
            },
            "filter": {
                "not": {
                    "nested": {
                        "path": "controlled_fields",
                        "filter": {
                            "not": {
                                "terms": {
                                    "controlled_fields.controlled_field": ["A", "B", "D", "X", "Y"]
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
'
