#!/bin/bash
#
# This script demonstrates the effect of changing precision_step on numbers
#
curl -XDELETE localhost:9200/test-precision-1,test-precision-8,test-precision-64
echo
for i in 1 8 64; do curl -XPUT localhost:9200/test-precision-$i -d "{
    \"settings\": {
        \"index\": {
            \"number_of_shards\": 1,
            \"number_of_replicas\": 0
        }
    },
    \"mappings\": {
        \"doc\": {
            \"_source\": {
                \"enabled\": false
            },
            \"_all\": {
                \"enabled\": false
            },
            \"properties\": {
                \"num\": {
                    \"type\": \"long\",
                    \"precision_step\": $i
                }
            }
        }
    }
}"; echo; done
echo
echo Indexing....
for i in 1 8 64; do for n in {1..10000}; do curl -s -XPUT localhost:9200/test-precision-$i/doc/$n -d "{\"num\":$RANDOM}" > /dev/null; done; done
echo Done
echo Optimizing
curl -XPOST 'http://localhost:9200/test-precision-1,test-precision-8,test-precision-64/_optimize?max_num_segments=1&flush=true&wait_for_merge=true'
echo
for i in {1,8,64}; do curl -s -XGET "http://localhost:9200/test-precision-$i/_segments?pretty=true" | grep "test-precision\|size_in_bytes"; done
