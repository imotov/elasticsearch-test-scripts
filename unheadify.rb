#!/usr/bin/env ruby
# Converts json butchered by elasticsearch head plugin into real json
# Usage: ruby unheadify.rb < butchered.json > real.json

require 'rubygems'
require 'json'

class Unheadify
  def initialize()
    @stdin = STDIN
  end
  
  def run
    normalize(parse())
  end
  
  def normalize(index)
    index.delete("state")
    settings = index["settings"]
    index["settings"] = reduce(index["settings"])
    index
  end
  
  def reduce(settings)
    new_settings = {}
    settings.each do |key, value|
      put(new_settings, key, value)
    end
    new_settings
  end
  
  def put(hash, key, value)
    pos = key.index(".")
    if pos
      head = key[0..pos-1]
      tail = key[pos+1..-1]
      if !hash.has_key?(head)
        if is_numeric?(tail)
          hash[head] = []          
        else
          hash[head] = {}
        end
      end
      put(hash[head], tail, value)
    else
      if is_numeric?(key)
        hash[Integer(key)] = value
      else
        hash[key] = value
      end
    end
  end
  
  def parse
    output = ""
    commas = [false];
    first = true;
    @stdin.each do |line|
      line.strip!
      if line == '{' || line == '}' || line == ']'
        if first
          first = false
        else
          output << "\n"
        end
        output << line
      else
        if commas[-1]
          output << ","
        end
        output << "\n"
        (key, val) = line.split(": ")
        if val
          if val == "true" || val == "false" || is_numeric?(val) || line.end_with?("{") || line.end_with?("[")
            output << "\"" << key << "\": " << val
          else
            output << "\"" << key << "\": \"" << val << "\""
          end
        else
          output << "\"" << key << "\""
        end
        commas[-1] = true
      end
      if line.end_with?("{") || line.end_with?("[")
        commas.push(false)
      elsif line.end_with?("}") || line.end_with?("]")
        commas.pop()
      end
    end
    JSON.parse(output)
  end
  
  def is_numeric?(val)
    Float(val)
    true 
  rescue 
    false
  end


end

# puts Unheadify.new().run
puts JSON.pretty_generate(Unheadify.new().run)

