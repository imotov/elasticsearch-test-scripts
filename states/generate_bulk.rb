#!/usr/bin/env ruby
# Generates bulk loading script for states index

require 'rubygems'
require 'csv'
require 'json'

raise ArgumentError, "usage: load_states.rb <states CSV file> <cities CSV file> <index name> | zsh" if ARGV.size != 3

class BulkScriptGenerator
  def initialize(state_file, city_file, index, state, city, host)
    @state_file = state_file
    @city_file = city_file
    @index = index
    @state = state
    @city = city
    @host = host
    @states = {}
  end
  
  def generate
    @output = "#!/bin/bash\n"
    generate_mapper
    generate_state_data
    generate_city_data
  end
  
  private 
  
  def generate_state_data
    @output << "curl -XPOST \'http://"+ @host + ":9200/_bulk'  --data-binary \'"
    header = { 'index' => { '_index' => @index, '_type' => @state } }
    first = true
    fields = []
    CSV.foreach(@state_file,"r") do |row|
      if first
        first = false
        fields = row
      else
        rec = Hash[fields.zip row]
        @states[rec['state']] = rec['abbreviation']
        rec['location'] =  Hash['lat' => rec['lat'], 'lon' =>  rec['lon']]
        rec.delete('lat')
        rec.delete('lon')
        rec['location']
        rec['nicknames'] = rec['nicknames'].split("; ")
        header['index']['_id'] = rec['abbreviation']
        @output << header.to_json() + "\n"
        @output << rec.to_json().to_str().gsub(/[']/,"\'\\\\\'\'") + "\n"
      end
    end
    @output << "\'\n"
    @output << "echo\n"
  end
  
  def generate_city_data
    @output << "curl -XPOST \'http://"+ @host + ":9200/_bulk'  --data-binary \'"
    header = { 'index' => { '_index' => @index, '_type' => @city } }
    first = true
    fields = []
    CSV.foreach(@city_file,"r") do |row|
      if first
        first = false
        fields = row
      else
        rec = Hash[fields.zip row]
        rec['location'] =  Hash['lat' => rec['lat'], 'lon' =>  rec['lon']]
        rec.delete('lat')
        rec.delete('lon')
        rec['abbreviation'] =  @states[rec['state']]
        header['index']['_id'] = rec['rank']
        header['index']['_parent'] = rec['abbreviation']
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
    "index": {
      "number_of_shards": 1,
      "number_of_replicas": 0,
      "mapper.dynamic": false,
      "analysis": {
        "analyzer": {
          "my_text": {
            "tokenizer": "standard",
            "filter": ["lowercase", "snowball"]
          }
        }
      }
    }
  },
  "mappings": {
    "' + @state + '": {
      "_source": {
        "enabled": true
      },
      "properties": {
        "abbreviation": {
          "type": "string",
          "index": "no"
        },
        "bird": {
          "type" : "multi_field",
          "fields" : {
              "bird" : {"type" : "string", "analyzer" : "my_text"},
              "raw" : {"type" : "string", "index" : "not_analyzed"}
          }
        },
        "capital": {
          "type": "string",
          "index": "not_analyzed"
        },
        "flower": {
          "type" : "multi_field",
          "fields" : {
              "flower" : {"type" : "string", "analyzer" : "my_text"},
              "raw" : {"type" : "string", "index" : "not_analyzed"}
          }
        },
        "land_area": {
          "type": "double"
        },
        "location": {
          "type": "geo_point"
        },
        "motto": {
          "type": "string",
          "analyzer": "my_text"
        },
        "nicknames": {
          "type": "string",
          "analyzer": "my_text"
        },
        "song": {
          "type" : "multi_field",
          "fields" : {
              "song" : {"type" : "string", "analyzer" : "my_text"},
              "raw" : {"type" : "string", "index" : "not_analyzed"}
          }
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
          "type" : "multi_field",
          "fields" : {
              "tree" : {"type" : "string", "analyzer" : "my_text"},
              "raw" : {"type" : "string", "index" : "not_analyzed"}
          }
        },
        "water_area": {
          "type": "double"
        }
      }
    },
    "' + @city + '": {
      "_parent": {
        "type": "' + @state + '"
      },
      "properties": {
        "ansi" : {
          "type" : "long"
        },
        "abbreviation" : {
          "type" : "string",
          "index": "not_analyzed"
        },
        "city" : {
          "type" : "string"
        },
        "density" : {
          "type" : "double"
        },
        "land_area" : {
          "type" : "double"
        },
        "location" : {
          "type": "geo_point"
        },
        "population2010" : {
          "type" : "string"
        },
        "population2012" : {
          "type" : "string"
        },
        "rank" : {
          "type" : "string"
        },
        "state" : {
          "type" : "string"
        }
      }
    }
  }
}
'
    @output << "\'\n"
  end
      
end

puts BulkScriptGenerator.new(ARGV[0], ARGV[1], ARGV[2], 'states', 'cities', 'localhost').generate
