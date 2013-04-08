curl -XDELETE 'http://localhost:9200/test-idx'
echo
curl -XPUT 'http://localhost:9200/test-idx'
echo
echo
echo "**** Standard analyzer ****"
curl 'http://localhost:9200/test-idx/_analyze?pretty=true' -d 'This is a test of somemailaddress@gmail.com'
echo
curl -XDELETE 'http://localhost:9200/test-idx'
echo
echo
echo "**** Email analyzer ****"
    curl -XPUT 'http://localhost:9200/test-idx' -d '{
      "settings" : {
        "index": {
          "analysis" :{
            "analyzer": {
              "default": {
                "type" : "custom",
                "tokenizer" : "uax_url_email",
                "filter" : ["standard", "lowercase", "stop"]
              }
            }
          }
        }
      }
    }
    '
echo
curl 'http://localhost:9200/test-idx/_analyze?pretty=true' -d 'This is a test of somemailaddress@gmail.com'
echo


