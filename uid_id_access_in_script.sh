    curl -XDELETE localhost:9200/test
    curl -XPUT localhost:9200/test -d '{
        "settings": {
            "index.number_of_shards": 1,
            "index.number_of_replicas": 0
        },
        "mappings": {
            "doc": {
                "properties": {
                    "name": {
                        "type": "string"
                    }
                }
            },
            "child_doc": {
                "_parent": {
                    "type": "doc"
                },
                "properties": {
                    "name": {
                        "type": "string"
                    }
                }
            }
        }
    }'
    curl -XPUT "localhost:9200/test/doc/1" -d '{"name": "doc 1"}'
    curl -XPUT "localhost:9200/test/child_doc/1-1?parent=1" -d '{"name": "child 1-1 of doc 1"}'
    curl -XPOST "localhost:9200/test/_refresh"
    echo
    curl "localhost:9200/test/child_doc/_search?pretty=true" -d '{
        "script_fields": {
            "uid_in_script": {
                "script": "doc[\"_uid\"].value"
            },
            "id_in_script": {
                "script": "org.elasticsearch.index.mapper.Uid.idFromUid(doc[\"_uid\"].value)"
            },
            "parent_uid_in_script": {
                "script": "doc[\"_parent\"].value"
            },
            "parent_id_in_script": {
                "script": "org.elasticsearch.index.mapper.Uid.idFromUid(doc[\"_parent\"].value)"
            },
            "parent_type_in_script": {
                "script": "org.elasticsearch.index.mapper.Uid.typeFromUid(doc[\"_parent\"].value)"
            }
        }
    }'
    echo
