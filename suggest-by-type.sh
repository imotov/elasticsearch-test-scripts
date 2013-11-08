#!/bin/bash
#
# Example of using suggested on selected types
#
curl -XDELETE "localhost:9200/test-idx?pretty"
curl -XPUT "localhost:9200/test-idx?pretty" -d '{
    "settings": {
        "number_of_shards": 1,
        "number_of_replicas": 0
    },
    "mappings": {
        "foo": {
            "properties": {
                "text": {
                    "type": "multi_field",
                    "fields": {
                        "text": { "type": "string"},
                        "foo": { "type": "string"}
                    }
                }
            }
        },
        "bar": {
            "properties": {
                "text": {
                    "type": "multi_field",
                    "fields": {
                        "text": { "type": "string"},
                        "bar": { "type": "string"}
                    }
                }
            }
        },
        "baz": {
            "properties": {
                "text": {
                    "type": "multi_field",
                    "fields": {
                        "text": { "type": "string"},
                        "baz": { "type": "string"}
                    }
                }
            }
        }
        
    }
}'
curl -XPOST "localhost:9200/test-idx/foo?pretty" -d '{"text": "Finding Nemo"}'
curl -XPOST "localhost:9200/test-idx/bar?pretty" -d '{"text": "Nil sine numine"}'
curl -XPOST "localhost:9200/test-idx/baz?pretty" -d '{"text": "El nino effect"}'
curl -XPOST "localhost:9200/test-idx/_refresh?pretty"
# Getting suggestion from all type
curl -XGET 'localhost:9200/test-idx/_suggest?pretty' -d '{
    "all": {
        "text": "nilo",
        "term": {
            "field": "text"
        }
    }
}'
# Getting suggestion from each type
curl -XGET 'localhost:9200/test-idx/_suggest?pretty' -d '{
    "foo": {
        "text": "nilo",
        "term": {
            "field": "text.foo"
        }
    }, 
    "bar": {
        "text": "nilo",
        "term": {
            "field": "text.bar"
        }
    }, 
    "baz": {
        "text": "nilo",
        "term": {
            "field": "text.baz"
        }
    }
}'