#!/usr/bin/env ruby
# Generates bulk loading script for states index

require 'rubygems'
require 'csv'
require 'json'

raise ArgumentError, "usage: load_states.rb <states CSV file> <index name> | zsh" if ARGV.size != 2

class BulkScriptGenerator
  def initialize(file, index, type, host)
    @file = file
    @index = index
    @type = type
    @host = host
  end
  
  def generate
    @output = "#!/bin/bash\n"
    generate_mapper
    generate_data
  end
  
  private 
  
  def generate_data
    @output << "curl -XPOST \'http://"+ @host + ":9200/_bulk'  --data-binary \'"
    header = { 'index' => { '_index' => @index, '_type' => @type } }
    first = true
    fields = []
    CSV.foreach(@file,"r") do |row|
      if first
        first = false
        fields = row
      else
         rec = Hash[fields.zip row]
         rec['location'] =  Hash['lat' => rec['lat'], 'lon' =>  rec['lon']]
         rec.delete('lat')
         rec.delete('lon')
         header['index']['_id'] = rec['abbreviation']
         @output << header.to_json() + "\n"
         @output << rec.to_json().to_str().gsub(/[']/,"\'\\\\\'\'") + "\n"
      end
    end
    @output << "\'\n"
    @output << "echo\n"
  end
  
  def generate_mapper
    @output << "curl -XDELETE \'http://"+ @host + ":9200/" + @index + "/\'\n"
    @output << "curl -XPUT \'http://"+ @host + ":9200/" + @index + "/\' -d \'"
    @output << '{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 1,
    "mapper.dynamic": false
  },
  "mappings": {
    "' + @type + '": {
      "_source": {
        "enabled": true
      },
      "properties": {
        "abbreviation": {
          "type": "string",
          "index": "no"
        },
        "bird": {
          "type": "string"
        },
        "capital": {
          "type": "string",
          "index": "not_analyzed"
        },
        "flower": {
          "type": "string"
        },
        "land_area": {
          "type": "double"
        },
        "location": {
          "type": "geo_point"
        },
        "motto": {
          "type": "string"
        },
        "nicknames": {
          "type": "string",
          "store": "yes"
        },
        "song": {
          "type": "string"
        },
        "state": {
          "type": "string",
          "index": "not_analyzed"
        },
        "status": {
          "type": "string",
          "index": "not_analyzed"
        },
        "total_area": {
          "type": "double"
        },
        "tree": {
          "type": "string"
        },
        "water_area": {
          "type": "double"
        }
      }
    }
  }
}
'
    @output << "\'\n"
  end
      
end

puts BulkScriptGenerator.new(ARGV[0], ARGV[1], 'states', 'localhost').generate
