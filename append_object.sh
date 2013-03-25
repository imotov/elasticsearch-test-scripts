#!/bin/bash
#
# Example of adding an object to an array using Update API
#

curl -XDELETE localhost:9200/test
curl -XPUT localhost:9200/test -d '{
    "settings": {
        "index.number_of_shards": 1,
        "index.number_of_replicas": 0
    },
    "mappings": {
        "doc": {
        }
    }
}'
curl -XPUT localhost:9200/test/doc/1 -d '{"types":[{"label":"key","value":"value"}],"name":"Foobar"}'
echo
curl -XPOST localhost:9200/test/doc/1/_update -d '{
    "script" : "ctx._source.types += newobject",
    "params" : {
        "newobject" : {"label":"key2","value":"test2"}
    }
}'
echo
curl "localhost:9200/test/doc/1?pretty=true"
echo
