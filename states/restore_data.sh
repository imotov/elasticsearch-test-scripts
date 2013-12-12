echo "Registering repository"
curl -XPUT 'http://localhost:9200/_snapshot/es_demo_data?pretty' -d '{
    "type": "url",
    "settings": {
        "url": "http://imotov.s3-website-us-west-2.amazonaws.com/demo/"
    }
}'
echo "Restoring demo index"
curl -XPOST "http://localhost:9200/_snapshot/es_demo_data/test/_restore?wait_for_completion=true&pretty" -d '{
    "indices": "large_us_cities"
}'
echo "Waiting for demo index to start"
curl -XGET "http://localhost:9200/_cluster/health/large_us_cities?wait_for_status=yellow&pretty"
echo "Test search"
curl -XGET "http://localhost:9200/large_us_cities/cities/_search?pretty" -d '{
    "query": {
        "range": {
            "population2012": {
                "from": 500000,
                "to": 1000000
            } 
        }
    },
    "fields": [ "state", "city", "population2012" ]
}'