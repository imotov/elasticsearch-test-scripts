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
                "geo_points": {
                    "properties": {
                        "point": {
                            "type": "geo_point"
                        }
                    }
                }
            }
        }
    }
}
'
echo
 
curl -XPOST 'localhost:9200/geotest/doc/1' -d '{
    "name": "foo",
    "geo_points": [ {
        "point": "59.957,30.303"
    }, {
        "point": "0.004,0.004"
    }, {
        "point": "59.948,30.276"
    }, {
        "point": "59.944,30.272"
    }]
}'
echo
curl -XPOST 'localhost:9200/geotest/_refresh'
echo
curl 'localhost:9200/geotest/doc/_search?pretty' -d'{
    "query": {
        "match_all": {}
    },
    "sort": {
        "_script": {
            "script": "import org.elasticsearch.common.geo.GeoDistance; import org.elasticsearch.common.unit.DistanceUnit; Collections.min((GeoDistance.ARC.calculate($.lat, $.lon, plat, plon, DistanceUnit.MILES) in doc[\"geo_points.point\"].values))",
            "type": "number",
            "params": {
                "plat": 55.0,
                "plon": 30.0
            },
            "order": "asc"
        }
    }
}
'
