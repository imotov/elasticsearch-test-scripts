#!/bin/bash
#
# This script demonstrates how to perform record grouping with sorting
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
                "company": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "product": {
                    "type": "string"
                },
                "registered": {
                    "type": "date"
                }
            }
        }
    }
}
'
curl -XPUT "localhost:9200/test-idx/doc/1" -d '{"company": "foo", "product": "test", "registered": "2015-01-01"}'
curl -XPUT "localhost:9200/test-idx/doc/2" -d '{"company": "foo", "product": "other", "registered": "2014-01-01"}'
curl -XPUT "localhost:9200/test-idx/doc/3" -d '{"company": "bar", "product": "other", "registered": "2015-02-01"}'
curl -XPUT "localhost:9200/test-idx/doc/4" -d '{"company": "bar", "product": "test", "registered": "2014-02-01"}'
curl -XPUT "localhost:9200/test-idx/doc/5" -d '{"company": "bar", "product": "test and other", "registered": "2015-03-01"}'
curl -XPOST "localhost:9200/test-idx/_refresh?pretty"
# Group products by company, sort companies by earliest registration date, sort products inside companies by _score
curl "localhost:9200/test-idx/doc/_search?pretty&search_tyep=count" -d '{
	"query": {
		"match": {
			"product": "test"
		}
	},
	"aggs": {
		"companies": {
			"terms": {
				"field": "company",
				"size": 100,
				"order": {
					"top_hit": "asc"
				}
			},
			"aggs": {
				"top-products": {
					"top_hits": {
						"size": 100
					}
				}, 
				"top_hit" : {
         		   "min": {
					   "field": "registered"
				   }
			   }
			}
		}
	}
}'
# Group products by company, sort companies by highets _score, sort products inside companies by _score
curl "localhost:9200/test-idx/doc/_search?pretty&search_tyep=count" -d '{
	"query": {
		"match": {
			"product": "test"
		}
	},
	"aggs": {
		"companies": {
			"terms": {
				"field": "company",
				"size": 100,
				"order": {
					"top_hit": "desc"
				}
			},
			"aggs": {
				"top-products": {
					"top_hits": {
						"size": 100
					}
				}, 
				"top_hit" : {
         		   "max": {
					   "script": "_score"
				   }
			   }
			}
		}
	}
}'
