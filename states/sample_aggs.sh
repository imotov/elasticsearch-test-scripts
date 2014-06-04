curl -s -XGET 'localhost:9200/large_us_cities/_mapping?pretty'


curl -s -XGET 'localhost:9200/large_us_cities/states/_search?pretty' -d '{
    "query": {
        "match": {
            "motto": "liberty"
        }
    }
}'


curl -s -XGET 'localhost:9200/large_us_cities/states/_search?pretty' -d '{
    "query": {
        "match_all": {
        }
    },
    "post_filter": {
        "term": {
            "motto": "liberti"
        }
    },
    "aggs": {
        "popular_motto_words": {
            "terms": {
                "field": "motto"
            }
        }
    }
}'


curl -s -XGET 'localhost:9200/large_us_cities/states/_search?pretty&search_type=count' -d '{
    "query": {
        "match_all": { }
    },
    "aggs": {
        "popular_trees": {
            "terms": {
                "field": "tree.raw"
            }
        }
    }
}'


curl -s -XGET 'localhost:9200/large_us_cities/states/_search?pretty&search_type=count' -d '{
    "aggs": {
        "popular_trees": {
            "terms": {
                "field": "tree.raw"
            }
        },
        "popular_flowers": {
            "terms": {
                "field": "flower.raw"
            }
        }
    }
}'


curl -s -XGET 'localhost:9200/large_us_cities/states/_search?pretty&search_type=count' -d '{
    "query": {
        "match_all": { }
    },
    "aggs": {
        "popular_motto_words": {
            "terms": {
                "field": "tree"
            },
            "aggs": {
                "states": {
                    "terms": {
                        "field": "state"
                    }
                }
            }
        }
    }
}'


curl -s -XGET 'localhost:9200/large_us_cities/cities/_search?pretty&search_type=count' -d '{
    "aggs": {
        "pupulation_ranges": {
            "range": {
                "field": "population2012",
                "ranges": [
                {"from": "1000000"},
                {"from": "500000", "to": "1000000"},
                {"from": "200000",  "to": "500000"},
                {"from": "0",      "to": "200000"}
                ]
            },
            "aggs": {
                "avg_density": {
                    "extended_stats": {
                        "field": "density"
                    }
                }
            }
        }
    }
}'


curl -s -XGET 'localhost:9200/large_us_cities/cities/_search?pretty&search_type=count' -d '{
    "aggs": {
        "pupulation_ranges": {
            "range": {
                "field": "population2012",
                "ranges": [
                {"from": "1000000"},
                {"from": "500000", "to": "1000000"},
                {"from": "200000",  "to": "500000"},
                {"from": "0",      "to": "200000"}
                ]
            },
            "aggs": {
                "avg_density": {
                    "avg": {
                        "field": "density"
                    }
                },
                "states": {
                    "terms": {
                        "field": "state"
                    }
                }
            }
        }
    }
}'


