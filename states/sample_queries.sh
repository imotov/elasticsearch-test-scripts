curl -s 'localhost:9200/test-idx/cities/_search?pretty&fields=city,state' -d '{
    "sort": [
        {"state": {"order": "asc"}},
        {"population2010": {"order": "desc"}}
        
    ]
}'

# add state region for faceting
# average population by region
# index moto using snowball (facet for the most frequently used words in motto)
