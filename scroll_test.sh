#!/bin/bash
#
# Example of using scroll with sort
#
set -e 

USERNAME=elastic
PASSWORD=password
AUTH="-u $USERNAME:$PASSWORD"
ES=http://localhost:9200
curl $AUTH -XDELETE "$ES/test?allow_no_indices=true&pretty=true"
curl $AUTH -XPUT "$ES/test?pretty=true" -H 'Content-Type: application/json' -d '{
    "settings": {
        "index": {
            "number_of_shards": 1,
            "number_of_replicas": 0
        }
    },
    "mappings": {
        "properties": {
            "foo": {
                "type": "integer"
            }
        }
    }
}'
echo
echo Indexing....
for n in {1..2000}; do 
    curl $AUTH -s -XPOST "$ES/test/_doc" -H 'Content-Type: application/json' -d "{\"foo\":$RANDOM}" > /dev/null; 
done;
curl $AUTH -XPOST "$ES/test/_refresh?pretty"
echo Done
SCROLL_ID=$(curl $AUTH -s -XGET "$ES/test/_search?pretty&scroll=1m"  -H 'Content-Type: application/json' -d '{
    "size": 100,
    "aggs": {
        "avg_foo": { "avg": { "field": "foo" } }
    },
    "sort" : [
        { "foo" : "asc"}
    ]
}' | tee /dev/tty | jq "._scroll_id")
for n in {1..20}; do 
    SCROLL_ID=$(curl -s $AUTH -XGET "$ES/_search/scroll?pretty" -H 'Content-Type: application/json' -d '{
        "scroll" : "1m",
        "scroll_id" : '$SCROLL_ID'
    }' | tee /dev/tty | jq "._scroll_id")
done;