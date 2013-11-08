echo "----------------------------------------------------------------------"
echo "Find information about city of Boston"
curl 'localhost:9200/test-data/states/_search?pretty' -d '{
    "query": {
        "match": {
            "city": "Boston"
        }
    }
}'
echo
echo "----------------------------------------------------------------------"
echo "Find all cities with population between 500,000 and 1,000,000 people"
curl -XGET "http://localhost:9200/test-data/cities/_search?pretty" -d '{
    "query": {
        "range": {
            "population2012": {
                "from": 500000,
                "to": 1000000
            } 
        }
    }
}'
echo
echo "----------------------------------------------------------------------"
echo "Return all cities sorted by population"
curl -s 'localhost:9200/test-data/cities/_search?pretty&fields=city,state' -d '{
    "sort": [
        {"state": {"order": "asc"}},
        {"population2010": {"order": "desc"}}
        
    ]
}'
echo
echo "----------------------------------------------------------------------"
curl 'localhost:9200/test-data/states/_search?pretty' -d '{
    "explain": false,
    "query": {
        "query_string": {
            "query": "equal",
            "fields": ["motto", "nicknames^7"],
            "use_dis_max": true
        }
    }
}'
echo
echo "----------------------------------------------------------------------"
echo "Return all cities that have states that start with A"
curl 'localhost:9200/test-data/states/_search?pretty' -d '{
    "query": {
        "match": {
            "tree": "pine"
        }
    }
}'
echo
echo "Return all cities that start with C in states that have pine as a state tree"
curl 'localhost:9200/test-data/cities/_search?pretty' -d '{
    "query": {
        "bool": {
            "must": [{
                "wildcard": {
                    "city": "c*"
                }
            }, {
                "has_parent": {
                    "type": "states",
                    "query":{
                        "match": {
                            "tree": "pine"
                        }
                    }
                }
            }]
        }
    }
}'
echo
echo "Return states with pine as a state tree that have cities that start with C"
curl 'localhost:9200/test-data/states/_search?pretty' -d '{
    "query": {
        "bool": {
            "must": [{
                "match": {
                    "tree": "pine"
                }
            }, {
                "has_child": {
                    "type": "cities",
                    "query":{
                        "wildcard": {
                            "city": "c*"
                        }
                    }
                }
            }]
        }
    }
}'
echo
echo "And now combine these two together"
curl 'localhost:9200/test-data/_msearch?pretty' -d '{"type" : "states"}
{"query": {"bool": {"must": [{"match": {"tree": "pine"}}, {"has_child": {"type": "cities", "query":{"wildcard": {"city": "c*"}}}}]}}}
{"type" : "cities"}
{"query": {"bool": {"must": [{"wildcard": {"city": "c*"}}, {"has_parent": {"type": "states", "query":{"match": {"tree": "pine"}}}}]}}}
'
