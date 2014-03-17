#!/bin/bash
#
# Example of sorting on multiple geo_points
#
 
curl -XDELETE 'localhost:9200/geotest'
echo
curl -XPOST 'localhost:9200/geotest' -d'{
    "settings": {
        "number_of_replicas": 0,
        "number_of_shards": 1
    },
    "mappings": {
        "doc": {
            "properties": {
                "name": {
                    "type": "string"
                },
                "my_shape": {
                    "type": "geo_shape"
                }
            }
        }
    }
}
'
echo
curl -XPOST 'localhost:9200/geotest/doc/1' -d '{
    "name": "foo",
    "my_shape": {
        "type" : "envelope",
        "coordinates" : [[-45.0, 45.0], [45.0, -45.0]]
    }
}'
echo
curl -XPOST 'localhost:9200/geotest/doc/2' -d '{
    "name": "foo",
    "my_shape": {
        "type" : "polygon",
        "coordinates" : [
            [ [100.0, 0.0], [101.0, 0.0], [101.0, 1.0], [100.0, 1.0], [100.0, 0.0] ]
        ]
    }
}'
echo
curl -XPOST 'localhost:9200/geotest/doc/3' -d '{
    "name": "foo",
    "my_shape": {
        "type": "Point",
        "coordinates": [13.400544, 52.530286]
    }
}'

echo
curl -XPOST 'localhost:9200/geotest/_refresh'
echo
curl 'localhost:9200/geotest/doc/_search?pretty' -d'{
    "query":{
        "filtered": {
            "query": {
                "match_all": {}
            },
            "filter": {
                "geo_shape": {
                    "my_shape": {
                        "shape": {
                            "type": "envelope",
                            "coordinates" : [[13.0, 53.0], [14.0, 52.0]]
                        },
                        "relation": "within"
                    }
                }
            }
        }
    }
}
'
