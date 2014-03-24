curl -XDELETE 'http://localhost:9200/test-idx'
echo
curl -XPUT 'http://localhost:9200/test-idx'
echo
curl -XGET 'http://localhost:9200/_cluster/health?wait_for_yellow&index=test-idx'
echo
echo "**** Standard tokenizer ****"
curl 'http://localhost:9200/test-idx/_analyze?pretty=true' -d 'foo.bar.baz 10.4'
echo
curl -XDELETE 'http://localhost:9200/test-idx'
echo
echo
echo "**** Standard tokenizer with word delimiter ****"
curl -XPUT 'http://localhost:9200/test-idx' -d '{
	"settings": {
		"index": {
			"analysis": {
				"analyzer": {
					"default": {
						"type": "custom",
						"tokenizer": "standard",
						"filter": ["standard", "my_delim", "lowercase"]
					}
				},
				"filter": {
					"my_delim": {
						"type": "word_delimiter",
						"generate_word_parts": true,
						"generate_number_parts": false,
						"catenate_words": false,
						"catenate_numbers": false,
						"catenate_all": false,
						"split_on_case_change": false,
						"preserve_original": true,
						"split_on_numerics": false,
						"stem_english_possessive": false
					}
				}
			}
		}
	}
}
'
echo
curl 'http://localhost:9200/test-idx/_analyze?pretty=true' -d 'foo.bar.baz 10.4'
echo


