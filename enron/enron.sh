#!/bin/sh
#
# Loading enron data into elasticsearch
#
# Prerequisites: 
# make sure that stream2es utility is present in the path
# install beautifulsoup4 and lxml:
#    sudo easy_install beautifulsoup4
#    sudo easy_install lxml
#
# The mailboxes__jsonify_mbox.py and mailboxes__convert_enron_inbox_to_mbox.py are modified 
# versions of https://github.com/ptwobrussell/Mining-the-Social-Web/tree/master/python_code
#
if [ ! -d enron_mail_20110402 ]; then
    echo "Downloading enron file"
    curl -O -L http://www.cs.cmu.edu/~enron/enron_mail_20110402.tgz
    tar -xzf enron_mail_20110402.tgz
fi
if [ ! -f enron.mbox.json ]; then
    echo "Converting enron emails to mbox format"
    python mailboxes__convert_enron_inbox_to_mbox.py enron_mail_20110402 > enron.mbox
    echo "Converting enron emails to json format"
    python mailboxes__jsonify_mbox.py enron.mbox > enron.mbox.json
    rm enron.mbox
fi
echo "Indexing enron emails"
es_host="http://localhost:9200"
curl -XDELETE "$es_host/enron"
curl -XPUT "$es_host/enron" -d '{
    "settings": {
        "index.number_of_replicas": 0,
        "index.number_of_shards": 5,
        "index.refresh_interval": -1
    },
    "mappings": {
        "email": {
            "properties": {
                "Bcc": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "Cc": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "Content-Transfer-Encoding": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "Content-Type": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "Date": {
                    "type" : "date",
                    "format" : "EEE, dd MMM YYYY HH:mm:ss Z"
                },
                "From": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "Message-ID": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "Mime-Version": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "Subject": {
                    "type": "string"
                },
                "To": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "X-FileName": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "X-Folder": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "X-From": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "X-Origin": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "X-To": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "X-bcc": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "X-cc": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "bytes": {
                    "type": "long"
                },
                "offset": {
                    "type": "long"
                },
                "parts": {
                    "dynamic": "true",
                    "properties": {
                        "content": {
                            "type": "string"
                        },
                        "contentType": {
                            "type": "string",
                            "index": "not_analyzed"
                        }
                    }
                }
            }
        }
    }
}'
stream2es stdin -i enron -t email --target $es_host < enron.mbox.json
