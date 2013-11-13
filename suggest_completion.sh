#!/bin/bash
#
# Example of completion suggesters based on city names
#
curl -XDELETE "localhost:9200/test-idx?pretty"
curl -XPUT "localhost:9200/test-idx?pretty" -d '{
    "settings": {
        "number_of_shards": 1,
        "number_of_replicas": 0
    },
    "mappings": {
        "cities": {
            "properties": {
                "name" : { "type" : "string" },
                "suggest" : { "type" : "completion",
                              "index_analyzer" : "simple",
                              "search_analyzer" : "simple",
                              "payloads" : false
                }
            }
        }
    }
}'
curl -XPOST 'localhost:9200/test-idx/cities/_bulk' --data-binary '{"index": {}}
{ "name" : "New York", "suggest" : { "input": [ "New", "York" ], "output": "New York" } }
{"index": {}}
{ "name" : "Los Angeles", "suggest" : { "input": [ "Los", "Angeles" ], "output": "Los Angeles" } }
{"index": {}}
{ "name" : "Chicago", "suggest" : { "input": [ "Chicago" ], "output": "Chicago" } }
{"index": {}}
{ "name" : "Houston", "suggest" : { "input": [ "Houston" ], "output": "Houston" } }
{"index": {}}
{ "name" : "Philadelphia", "suggest" : { "input": [ "Philadelphia" ], "output": "Philadelphia" } }
{"index": {}}
{ "name" : "Phoenix", "suggest" : { "input": [ "Phoenix" ], "output": "Phoenix" } }
{"index": {}}
{ "name" : "San Antonio", "suggest" : { "input": [ "San", "Antonio" ], "output": "San Antonio" } }
{"index": {}}
{ "name" : "San Diego", "suggest" : { "input": [ "San", "Diego" ], "output": "San Diego" } }
{"index": {}}
{ "name" : "Dallas", "suggest" : { "input": [ "Dallas" ], "output": "Dallas" } }
{"index": {}}
{ "name" : "San Jose", "suggest" : { "input": [ "San", "Jose" ], "output": "San Jose" } }
{"index": {}}
{ "name" : "Austin", "suggest" : { "input": [ "Austin" ], "output": "Austin" } }
{"index": {}}
{ "name" : "Jacksonville", "suggest" : { "input": [ "Jacksonville" ], "output": "Jacksonville" } }
{"index": {}}
{ "name" : "Indianapolis", "suggest" : { "input": [ "Indianapolis" ], "output": "Indianapolis" } }
{"index": {}}
{ "name" : "San Francisco", "suggest" : { "input": [ "San", "Francisco" ], "output": "San Francisco" } }
{"index": {}}
{ "name" : "Columbus", "suggest" : { "input": [ "Columbus" ], "output": "Columbus" } }
{"index": {}}
{ "name" : "Fort Worth", "suggest" : { "input": [ "Fort", "Worth" ], "output": "Fort Worth" } }
{"index": {}}
{ "name" : "Charlotte", "suggest" : { "input": [ "Charlotte" ], "output": "Charlotte" } }
{"index": {}}
{ "name" : "Detroit", "suggest" : { "input": [ "Detroit" ], "output": "Detroit" } }
{"index": {}}
{ "name" : "El Paso", "suggest" : { "input": [ "El", "Paso" ], "output": "El Paso" } }
{"index": {}}
{ "name" : "Memphis", "suggest" : { "input": [ "Memphis" ], "output": "Memphis" } }
{"index": {}}
{ "name" : "Boston", "suggest" : { "input": [ "Boston" ], "output": "Boston" } }
{"index": {}}
{ "name" : "Seattle", "suggest" : { "input": [ "Seattle" ], "output": "Seattle" } }
{"index": {}}
{ "name" : "Denver", "suggest" : { "input": [ "Denver" ], "output": "Denver" } }
{"index": {}}
{ "name" : "Washington", "suggest" : { "input": [ "Washington" ], "output": "Washington" } }
{"index": {}}
{ "name" : "Nashville", "suggest" : { "input": [ "Nashville" ], "output": "Nashville" } }
{"index": {}}
{ "name" : "Baltimore", "suggest" : { "input": [ "Baltimore" ], "output": "Baltimore" } }
{"index": {}}
{ "name" : "Louisville", "suggest" : { "input": [ "Louisville" ], "output": "Louisville" } }
{"index": {}}
{ "name" : "Portland", "suggest" : { "input": [ "Portland" ], "output": "Portland" } }
{"index": {}}
{ "name" : "Oklahoma City", "suggest" : { "input": [ "Oklahoma", "City" ], "output": "Oklahoma City" } }
{"index": {}}
{ "name" : "Milwaukee", "suggest" : { "input": [ "Milwaukee" ], "output": "Milwaukee" } }
{"index": {}}
{ "name" : "Las Vegas", "suggest" : { "input": [ "Las", "Vegas" ], "output": "Las Vegas" } }
{"index": {}}
{ "name" : "Albuquerque", "suggest" : { "input": [ "Albuquerque" ], "output": "Albuquerque" } }
{"index": {}}
{ "name" : "Tucson", "suggest" : { "input": [ "Tucson" ], "output": "Tucson" } }
{"index": {}}
{ "name" : "Fresno", "suggest" : { "input": [ "Fresno" ], "output": "Fresno" } }
{"index": {}}
{ "name" : "Sacramento", "suggest" : { "input": [ "Sacramento" ], "output": "Sacramento" } }
{"index": {}}
{ "name" : "Long Beach", "suggest" : { "input": [ "Long", "Beach" ], "output": "Long Beach" } }
{"index": {}}
{ "name" : "Kansas City", "suggest" : { "input": [ "Kansas", "City" ], "output": "Kansas City" } }
{"index": {}}
{ "name" : "Mesa", "suggest" : { "input": [ "Mesa" ], "output": "Mesa" } }
{"index": {}}
{ "name" : "Virginia Beach", "suggest" : { "input": [ "Virginia", "Beach" ], "output": "Virginia Beach" } }
{"index": {}}
{ "name" : "Atlanta", "suggest" : { "input": [ "Atlanta" ], "output": "Atlanta" } }
{"index": {}}
{ "name" : "Colorado Springs", "suggest" : { "input": [ "Colorado", "Springs" ], "output": "Colorado Springs" } }
{"index": {}}
{ "name" : "Raleigh", "suggest" : { "input": [ "Raleigh" ], "output": "Raleigh" } }
{"index": {}}
{ "name" : "Omaha", "suggest" : { "input": [ "Omaha" ], "output": "Omaha" } }
{"index": {}}
{ "name" : "Miami", "suggest" : { "input": [ "Miami" ], "output": "Miami" } }
{"index": {}}
{ "name" : "Oakland", "suggest" : { "input": [ "Oakland" ], "output": "Oakland" } }
{"index": {}}
{ "name" : "Tulsa", "suggest" : { "input": [ "Tulsa" ], "output": "Tulsa" } }
{"index": {}}
{ "name" : "Minneapolis", "suggest" : { "input": [ "Minneapolis" ], "output": "Minneapolis" } }
{"index": {}}
{ "name" : "Cleveland", "suggest" : { "input": [ "Cleveland" ], "output": "Cleveland" } }
{"index": {}}
{ "name" : "Wichita", "suggest" : { "input": [ "Wichita" ], "output": "Wichita" } }
{"index": {}}
{ "name" : "Arlington", "suggest" : { "input": [ "Arlington" ], "output": "Arlington" } }
{"index": {}}
{ "name" : "New Orleans", "suggest" : { "input": [ "New", "Orleans" ], "output": "New Orleans" } }
{"index": {}}
{ "name" : "Bakersfield", "suggest" : { "input": [ "Bakersfield" ], "output": "Bakersfield" } }
{"index": {}}
{ "name" : "Tampa", "suggest" : { "input": [ "Tampa" ], "output": "Tampa" } }
{"index": {}}
{ "name" : "Honolulu", "suggest" : { "input": [ "Honolulu" ], "output": "Honolulu" } }
{"index": {}}
{ "name" : "Anaheim", "suggest" : { "input": [ "Anaheim" ], "output": "Anaheim" } }
{"index": {}}
{ "name" : "Aurora", "suggest" : { "input": [ "Aurora" ], "output": "Aurora" } }
{"index": {}}
{ "name" : "Santa Ana", "suggest" : { "input": [ "Santa", "Ana" ], "output": "Santa Ana" } }
{"index": {}}
{ "name" : "St. Louis", "suggest" : { "input": [ "St.", "Louis" ], "output": "St. Louis" } }
{"index": {}}
{ "name" : "Riverside", "suggest" : { "input": [ "Riverside" ], "output": "Riverside" } }
{"index": {}}
{ "name" : "Corpus Christi", "suggest" : { "input": [ "Corpus", "Christi" ], "output": "Corpus Christi" } }
{"index": {}}
{ "name" : "Pittsburgh", "suggest" : { "input": [ "Pittsburgh" ], "output": "Pittsburgh" } }
{"index": {}}
{ "name" : "Lexington", "suggest" : { "input": [ "Lexington" ], "output": "Lexington" } }
{"index": {}}
{ "name" : "Anchorage", "suggest" : { "input": [ "Anchorage" ], "output": "Anchorage" } }
{"index": {}}
{ "name" : "Stockton", "suggest" : { "input": [ "Stockton" ], "output": "Stockton" } }
{"index": {}}
{ "name" : "Cincinnati", "suggest" : { "input": [ "Cincinnati" ], "output": "Cincinnati" } }
{"index": {}}
{ "name" : "Saint Paul", "suggest" : { "input": [ "Saint", "Paul" ], "output": "Saint Paul" } }
{"index": {}}
{ "name" : "Toledo", "suggest" : { "input": [ "Toledo" ], "output": "Toledo" } }
{"index": {}}
{ "name" : "Newark", "suggest" : { "input": [ "Newark" ], "output": "Newark" } }
{"index": {}}
{ "name" : "Greensboro", "suggest" : { "input": [ "Greensboro" ], "output": "Greensboro" } }
{"index": {}}
{ "name" : "Plano", "suggest" : { "input": [ "Plano" ], "output": "Plano" } }
{"index": {}}
{ "name" : "Henderson", "suggest" : { "input": [ "Henderson" ], "output": "Henderson" } }
{"index": {}}
{ "name" : "Lincoln", "suggest" : { "input": [ "Lincoln" ], "output": "Lincoln" } }
{"index": {}}
{ "name" : "Buffalo", "suggest" : { "input": [ "Buffalo" ], "output": "Buffalo" } }
{"index": {}}
{ "name" : "Fort Wayne", "suggest" : { "input": [ "Fort", "Wayne" ], "output": "Fort Wayne" } }
{"index": {}}
{ "name" : "Jersey City", "suggest" : { "input": [ "Jersey", "City" ], "output": "Jersey City" } }
{"index": {}}
{ "name" : "Chula Vista", "suggest" : { "input": [ "Chula", "Vista" ], "output": "Chula Vista" } }
{"index": {}}
{ "name" : "Orlando", "suggest" : { "input": [ "Orlando" ], "output": "Orlando" } }
{"index": {}}
{ "name" : "St. Petersburg", "suggest" : { "input": [ "St.", "Petersburg" ], "output": "St. Petersburg" } }
{"index": {}}
{ "name" : "Norfolk", "suggest" : { "input": [ "Norfolk" ], "output": "Norfolk" } }
{"index": {}}
{ "name" : "Chandler", "suggest" : { "input": [ "Chandler" ], "output": "Chandler" } }
{"index": {}}
{ "name" : "Laredo", "suggest" : { "input": [ "Laredo" ], "output": "Laredo" } }
{"index": {}}
{ "name" : "Madison", "suggest" : { "input": [ "Madison" ], "output": "Madison" } }
{"index": {}}
{ "name" : "Durham", "suggest" : { "input": [ "Durham" ], "output": "Durham" } }
{"index": {}}
{ "name" : "Lubbock", "suggest" : { "input": [ "Lubbock" ], "output": "Lubbock" } }
{"index": {}}
{ "name" : "Winston-Salem", "suggest" : { "input": [ "Winston-Salem" ], "output": "Winston-Salem" } }
{"index": {}}
{ "name" : "Garland", "suggest" : { "input": [ "Garland" ], "output": "Garland" } }
{"index": {}}
{ "name" : "Glendale", "suggest" : { "input": [ "Glendale" ], "output": "Glendale" } }
{"index": {}}
{ "name" : "Hialeah", "suggest" : { "input": [ "Hialeah" ], "output": "Hialeah" } }
{"index": {}}
{ "name" : "Reno", "suggest" : { "input": [ "Reno" ], "output": "Reno" } }
{"index": {}}
{ "name" : "Baton Rouge", "suggest" : { "input": [ "Baton", "Rouge" ], "output": "Baton Rouge" } }
{"index": {}}
{ "name" : "Irvine", "suggest" : { "input": [ "Irvine" ], "output": "Irvine" } }
{"index": {}}
{ "name" : "Chesapeake", "suggest" : { "input": [ "Chesapeake" ], "output": "Chesapeake" } }
{"index": {}}
{ "name" : "Irving", "suggest" : { "input": [ "Irving" ], "output": "Irving" } }
{"index": {}}
{ "name" : "Scottsdale", "suggest" : { "input": [ "Scottsdale" ], "output": "Scottsdale" } }
{"index": {}}
{ "name" : "North Las Vegas", "suggest" : { "input": [ "North Las", "Vegas" ], "output": "North Las Vegas" } }
{"index": {}}
{ "name" : "Fremont", "suggest" : { "input": [ "Fremont" ], "output": "Fremont" } }
{"index": {}}
{ "name" : "Gilbert", "suggest" : { "input": [ "Gilbert" ], "output": "Gilbert" } }
{"index": {}}
{ "name" : "San Bernardino", "suggest" : { "input": [ "San", "Bernardino" ], "output": "San Bernardino" } }
{"index": {}}
{ "name" : "Boise", "suggest" : { "input": [ "Boise" ], "output": "Boise" } }
{"index": {}}
{ "name" : "Birmingham", "suggest" : { "input": [ "Birmingham" ], "output": "Birmingham" } }
{"index": {}}
{ "name" : "Rochester", "suggest" : { "input": [ "Rochester" ], "output": "Rochester" } }
{"index": {}}
{ "name" : "Richmond", "suggest" : { "input": [ "Richmond" ], "output": "Richmond" } }
{"index": {}}
{ "name" : "Spokane", "suggest" : { "input": [ "Spokane" ], "output": "Spokane" } }
{"index": {}}
{ "name" : "Des Moines", "suggest" : { "input": [ "Des", "Moines" ], "output": "Des Moines" } }
{"index": {}}
{ "name" : "Montgomery", "suggest" : { "input": [ "Montgomery" ], "output": "Montgomery" } }
{"index": {}}
{ "name" : "Modesto", "suggest" : { "input": [ "Modesto" ], "output": "Modesto" } }
{"index": {}}
{ "name" : "Fayetteville", "suggest" : { "input": [ "Fayetteville" ], "output": "Fayetteville" } }
{"index": {}}
{ "name" : "Tacoma", "suggest" : { "input": [ "Tacoma" ], "output": "Tacoma" } }
{"index": {}}
{ "name" : "Shreveport", "suggest" : { "input": [ "Shreveport" ], "output": "Shreveport" } }
{"index": {}}
{ "name" : "Fontana", "suggest" : { "input": [ "Fontana" ], "output": "Fontana" } }
{"index": {}}
{ "name" : "Oxnard", "suggest" : { "input": [ "Oxnard" ], "output": "Oxnard" } }
{"index": {}}
{ "name" : "Aurora", "suggest" : { "input": [ "Aurora" ], "output": "Aurora" } }
{"index": {}}
{ "name" : "Moreno Valley", "suggest" : { "input": [ "Moreno", "Valley" ], "output": "Moreno Valley" } }
{"index": {}}
{ "name" : "Akron", "suggest" : { "input": [ "Akron" ], "output": "Akron" } }
{"index": {}}
{ "name" : "Yonkers", "suggest" : { "input": [ "Yonkers" ], "output": "Yonkers" } }
{"index": {}}
{ "name" : "Columbus", "suggest" : { "input": [ "Columbus" ], "output": "Columbus" } }
{"index": {}}
{ "name" : "Augusta", "suggest" : { "input": [ "Augusta" ], "output": "Augusta" } }
{"index": {}}
{ "name" : "Little Rock", "suggest" : { "input": [ "Little", "Rock" ], "output": "Little Rock" } }
{"index": {}}
{ "name" : "Amarillo", "suggest" : { "input": [ "Amarillo" ], "output": "Amarillo" } }
{"index": {}}
{ "name" : "Mobile", "suggest" : { "input": [ "Mobile" ], "output": "Mobile" } }
{"index": {}}
{ "name" : "Huntington Beach", "suggest" : { "input": [ "Huntington", "Beach" ], "output": "Huntington Beach" } }
{"index": {}}
{ "name" : "Glendale", "suggest" : { "input": [ "Glendale" ], "output": "Glendale" } }
{"index": {}}
{ "name" : "Grand Rapids", "suggest" : { "input": [ "Grand", "Rapids" ], "output": "Grand Rapids" } }
{"index": {}}
{ "name" : "Salt Lake City", "suggest" : { "input": [ "Salt Lake", "City" ], "output": "Salt Lake City" } }
{"index": {}}
{ "name" : "Tallahassee", "suggest" : { "input": [ "Tallahassee" ], "output": "Tallahassee" } }
{"index": {}}
{ "name" : "Huntsville", "suggest" : { "input": [ "Huntsville" ], "output": "Huntsville" } }
{"index": {}}
{ "name" : "Worcester", "suggest" : { "input": [ "Worcester" ], "output": "Worcester" } }
{"index": {}}
{ "name" : "Knoxville", "suggest" : { "input": [ "Knoxville" ], "output": "Knoxville" } }
{"index": {}}
{ "name" : "Grand Prairie", "suggest" : { "input": [ "Grand", "Prairie" ], "output": "Grand Prairie" } }
{"index": {}}
{ "name" : "Newport News", "suggest" : { "input": [ "Newport", "News" ], "output": "Newport News" } }
{"index": {}}
{ "name" : "Brownsville", "suggest" : { "input": [ "Brownsville" ], "output": "Brownsville" } }
{"index": {}}
{ "name" : "Santa Clarita", "suggest" : { "input": [ "Santa", "Clarita" ], "output": "Santa Clarita" } }
{"index": {}}
{ "name" : "Overland Park", "suggest" : { "input": [ "Overland", "Park" ], "output": "Overland Park" } }
{"index": {}}
{ "name" : "Providence", "suggest" : { "input": [ "Providence" ], "output": "Providence" } }
{"index": {}}
{ "name" : "Jackson", "suggest" : { "input": [ "Jackson" ], "output": "Jackson" } }
{"index": {}}
{ "name" : "Garden Grove", "suggest" : { "input": [ "Garden", "Grove" ], "output": "Garden Grove" } }
{"index": {}}
{ "name" : "Oceanside", "suggest" : { "input": [ "Oceanside" ], "output": "Oceanside" } }
{"index": {}}
{ "name" : "Chattanooga", "suggest" : { "input": [ "Chattanooga" ], "output": "Chattanooga" } }
{"index": {}}
{ "name" : "Fort Lauderdale", "suggest" : { "input": [ "Fort", "Lauderdale" ], "output": "Fort Lauderdale" } }
{"index": {}}
{ "name" : "Rancho Cucamonga", "suggest" : { "input": [ "Rancho", "Cucamonga" ], "output": "Rancho Cucamonga" } }
{"index": {}}
{ "name" : "Santa Rosa", "suggest" : { "input": [ "Santa", "Rosa" ], "output": "Santa Rosa" } }
{"index": {}}
{ "name" : "Port St. Lucie", "suggest" : { "input": [ "Port St.", "Lucie" ], "output": "Port St. Lucie" } }
{"index": {}}
{ "name" : "Ontario", "suggest" : { "input": [ "Ontario" ], "output": "Ontario" } }
{"index": {}}
{ "name" : "Tempe", "suggest" : { "input": [ "Tempe" ], "output": "Tempe" } }
{"index": {}}
{ "name" : "Vancouver", "suggest" : { "input": [ "Vancouver" ], "output": "Vancouver" } }
{"index": {}}
{ "name" : "Springfield", "suggest" : { "input": [ "Springfield" ], "output": "Springfield" } }
{"index": {}}
{ "name" : "Cape Coral", "suggest" : { "input": [ "Cape", "Coral" ], "output": "Cape Coral" } }
{"index": {}}
{ "name" : "Pembroke Pines", "suggest" : { "input": [ "Pembroke", "Pines" ], "output": "Pembroke Pines" } }
{"index": {}}
{ "name" : "Sioux Falls", "suggest" : { "input": [ "Sioux", "Falls" ], "output": "Sioux Falls" } }
{"index": {}}
{ "name" : "Peoria", "suggest" : { "input": [ "Peoria" ], "output": "Peoria" } }
{"index": {}}
{ "name" : "Lancaster", "suggest" : { "input": [ "Lancaster" ], "output": "Lancaster" } }
{"index": {}}
{ "name" : "Elk Grove", "suggest" : { "input": [ "Elk", "Grove" ], "output": "Elk Grove" } }
{"index": {}}
{ "name" : "Corona", "suggest" : { "input": [ "Corona" ], "output": "Corona" } }
{"index": {}}
{ "name" : "Eugene", "suggest" : { "input": [ "Eugene" ], "output": "Eugene" } }
{"index": {}}
{ "name" : "Salem", "suggest" : { "input": [ "Salem" ], "output": "Salem" } }
{"index": {}}
{ "name" : "Palmdale", "suggest" : { "input": [ "Palmdale" ], "output": "Palmdale" } }
{"index": {}}
{ "name" : "Salinas", "suggest" : { "input": [ "Salinas" ], "output": "Salinas" } }
{"index": {}}
{ "name" : "Springfield", "suggest" : { "input": [ "Springfield" ], "output": "Springfield" } }
{"index": {}}
{ "name" : "Pasadena", "suggest" : { "input": [ "Pasadena" ], "output": "Pasadena" } }
{"index": {}}
{ "name" : "Rockford", "suggest" : { "input": [ "Rockford" ], "output": "Rockford" } }
{"index": {}}
{ "name" : "Pomona", "suggest" : { "input": [ "Pomona" ], "output": "Pomona" } }
{"index": {}}
{ "name" : "Hayward", "suggest" : { "input": [ "Hayward" ], "output": "Hayward" } }
{"index": {}}
{ "name" : "Fort Collins", "suggest" : { "input": [ "Fort", "Collins" ], "output": "Fort Collins" } }
{"index": {}}
{ "name" : "Joliet", "suggest" : { "input": [ "Joliet" ], "output": "Joliet" } }
{"index": {}}
{ "name" : "Escondido", "suggest" : { "input": [ "Escondido" ], "output": "Escondido" } }
{"index": {}}
{ "name" : "Kansas City", "suggest" : { "input": [ "Kansas", "City" ], "output": "Kansas City" } }
{"index": {}}
{ "name" : "Torrance", "suggest" : { "input": [ "Torrance" ], "output": "Torrance" } }
{"index": {}}
{ "name" : "Bridgeport", "suggest" : { "input": [ "Bridgeport" ], "output": "Bridgeport" } }
{"index": {}}
{ "name" : "Alexandria", "suggest" : { "input": [ "Alexandria" ], "output": "Alexandria" } }
{"index": {}}
{ "name" : "Sunnyvale", "suggest" : { "input": [ "Sunnyvale" ], "output": "Sunnyvale" } }
{"index": {}}
{ "name" : "Cary", "suggest" : { "input": [ "Cary" ], "output": "Cary" } }
{"index": {}}
{ "name" : "Lakewood", "suggest" : { "input": [ "Lakewood" ], "output": "Lakewood" } }
{"index": {}}
{ "name" : "Hollywood", "suggest" : { "input": [ "Hollywood" ], "output": "Hollywood" } }
{"index": {}}
{ "name" : "Paterson", "suggest" : { "input": [ "Paterson" ], "output": "Paterson" } }
{"index": {}}
{ "name" : "Syracuse", "suggest" : { "input": [ "Syracuse" ], "output": "Syracuse" } }
{"index": {}}
{ "name" : "Naperville", "suggest" : { "input": [ "Naperville" ], "output": "Naperville" } }
{"index": {}}
{ "name" : "McKinney", "suggest" : { "input": [ "McKinney" ], "output": "McKinney" } }
{"index": {}}
{ "name" : "Mesquite", "suggest" : { "input": [ "Mesquite" ], "output": "Mesquite" } }
{"index": {}}
{ "name" : "Clarksville", "suggest" : { "input": [ "Clarksville" ], "output": "Clarksville" } }
{"index": {}}
{ "name" : "Savannah", "suggest" : { "input": [ "Savannah" ], "output": "Savannah" } }
{"index": {}}
{ "name" : "Dayton", "suggest" : { "input": [ "Dayton" ], "output": "Dayton" } }
{"index": {}}
{ "name" : "Orange", "suggest" : { "input": [ "Orange" ], "output": "Orange" } }
{"index": {}}
{ "name" : "Fullerton", "suggest" : { "input": [ "Fullerton" ], "output": "Fullerton" } }
{"index": {}}
{ "name" : "Pasadena", "suggest" : { "input": [ "Pasadena" ], "output": "Pasadena" } }
{"index": {}}
{ "name" : "Hampton", "suggest" : { "input": [ "Hampton" ], "output": "Hampton" } }
{"index": {}}
{ "name" : "McAllen", "suggest" : { "input": [ "McAllen" ], "output": "McAllen" } }
{"index": {}}
{ "name" : "Killeen", "suggest" : { "input": [ "Killeen" ], "output": "Killeen" } }
{"index": {}}
{ "name" : "Warren", "suggest" : { "input": [ "Warren" ], "output": "Warren" } }
{"index": {}}
{ "name" : "West Valley City", "suggest" : { "input": [ "West Valley", "City" ], "output": "West Valley City" } }
{"index": {}}
{ "name" : "Columbia", "suggest" : { "input": [ "Columbia" ], "output": "Columbia" } }
{"index": {}}
{ "name" : "New Haven", "suggest" : { "input": [ "New", "Haven" ], "output": "New Haven" } }
{"index": {}}
{ "name" : "Sterling Heights", "suggest" : { "input": [ "Sterling", "Heights" ], "output": "Sterling Heights" } }
{"index": {}}
{ "name" : "Olathe", "suggest" : { "input": [ "Olathe" ], "output": "Olathe" } }
{"index": {}}
{ "name" : "Miramar", "suggest" : { "input": [ "Miramar" ], "output": "Miramar" } }
{"index": {}}
{ "name" : "Thousand Oaks", "suggest" : { "input": [ "Thousand", "Oaks" ], "output": "Thousand Oaks" } }
{"index": {}}
{ "name" : "Frisco", "suggest" : { "input": [ "Frisco" ], "output": "Frisco" } }
{"index": {}}
{ "name" : "Cedar Rapids", "suggest" : { "input": [ "Cedar", "Rapids" ], "output": "Cedar Rapids" } }
{"index": {}}
{ "name" : "Topeka", "suggest" : { "input": [ "Topeka" ], "output": "Topeka" } }
{"index": {}}
{ "name" : "Visalia", "suggest" : { "input": [ "Visalia" ], "output": "Visalia" } }
{"index": {}}
{ "name" : "Waco", "suggest" : { "input": [ "Waco" ], "output": "Waco" } }
{"index": {}}
{ "name" : "Elizabeth", "suggest" : { "input": [ "Elizabeth" ], "output": "Elizabeth" } }
{"index": {}}
{ "name" : "Bellevue", "suggest" : { "input": [ "Bellevue" ], "output": "Bellevue" } }
{"index": {}}
{ "name" : "Gainesville", "suggest" : { "input": [ "Gainesville" ], "output": "Gainesville" } }
{"index": {}}
{ "name" : "Simi Valley", "suggest" : { "input": [ "Simi", "Valley" ], "output": "Simi Valley" } }
{"index": {}}
{ "name" : "Charleston", "suggest" : { "input": [ "Charleston" ], "output": "Charleston" } }
{"index": {}}
{ "name" : "Carrollton", "suggest" : { "input": [ "Carrollton" ], "output": "Carrollton" } }
{"index": {}}
{ "name" : "Coral Springs", "suggest" : { "input": [ "Coral", "Springs" ], "output": "Coral Springs" } }
{"index": {}}
{ "name" : "Stamford", "suggest" : { "input": [ "Stamford" ], "output": "Stamford" } }
{"index": {}}
{ "name" : "Hartford", "suggest" : { "input": [ "Hartford" ], "output": "Hartford" } }
{"index": {}}
{ "name" : "Concord", "suggest" : { "input": [ "Concord" ], "output": "Concord" } }
{"index": {}}
{ "name" : "Roseville", "suggest" : { "input": [ "Roseville" ], "output": "Roseville" } }
{"index": {}}
{ "name" : "Thornton", "suggest" : { "input": [ "Thornton" ], "output": "Thornton" } }
{"index": {}}
{ "name" : "Kent", "suggest" : { "input": [ "Kent" ], "output": "Kent" } }
{"index": {}}
{ "name" : "Lafayette", "suggest" : { "input": [ "Lafayette" ], "output": "Lafayette" } }
{"index": {}}
{ "name" : "Surprise", "suggest" : { "input": [ "Surprise" ], "output": "Surprise" } }
{"index": {}}
{ "name" : "Denton", "suggest" : { "input": [ "Denton" ], "output": "Denton" } }
{"index": {}}
{ "name" : "Victorville", "suggest" : { "input": [ "Victorville" ], "output": "Victorville" } }
{"index": {}}
{ "name" : "Evansville", "suggest" : { "input": [ "Evansville" ], "output": "Evansville" } }
{"index": {}}
{ "name" : "Midland", "suggest" : { "input": [ "Midland" ], "output": "Midland" } }
{"index": {}}
{ "name" : "Santa Clara", "suggest" : { "input": [ "Santa", "Clara" ], "output": "Santa Clara" } }
{"index": {}}
{ "name" : "Athens", "suggest" : { "input": [ "Athens" ], "output": "Athens" } }
{"index": {}}
{ "name" : "Allentown", "suggest" : { "input": [ "Allentown" ], "output": "Allentown" } }
{"index": {}}
{ "name" : "Abilene", "suggest" : { "input": [ "Abilene" ], "output": "Abilene" } }
{"index": {}}
{ "name" : "Beaumont", "suggest" : { "input": [ "Beaumont" ], "output": "Beaumont" } }
{"index": {}}
{ "name" : "Vallejo", "suggest" : { "input": [ "Vallejo" ], "output": "Vallejo" } }
{"index": {}}
{ "name" : "Independence", "suggest" : { "input": [ "Independence" ], "output": "Independence" } }
{"index": {}}
{ "name" : "Springfield", "suggest" : { "input": [ "Springfield" ], "output": "Springfield" } }
{"index": {}}
{ "name" : "Ann Arbor", "suggest" : { "input": [ "Ann", "Arbor" ], "output": "Ann Arbor" } }
{"index": {}}
{ "name" : "Provo", "suggest" : { "input": [ "Provo" ], "output": "Provo" } }
{"index": {}}
{ "name" : "Peoria", "suggest" : { "input": [ "Peoria" ], "output": "Peoria" } }
{"index": {}}
{ "name" : "Norman", "suggest" : { "input": [ "Norman" ], "output": "Norman" } }
{"index": {}}
{ "name" : "Berkeley", "suggest" : { "input": [ "Berkeley" ], "output": "Berkeley" } }
{"index": {}}
{ "name" : "El Monte", "suggest" : { "input": [ "El", "Monte" ], "output": "El Monte" } }
{"index": {}}
{ "name" : "Murfreesboro", "suggest" : { "input": [ "Murfreesboro" ], "output": "Murfreesboro" } }
{"index": {}}
{ "name" : "Lansing", "suggest" : { "input": [ "Lansing" ], "output": "Lansing" } }
{"index": {}}
{ "name" : "Columbia", "suggest" : { "input": [ "Columbia" ], "output": "Columbia" } }
{"index": {}}
{ "name" : "Downey", "suggest" : { "input": [ "Downey" ], "output": "Downey" } }
{"index": {}}
{ "name" : "Costa Mesa", "suggest" : { "input": [ "Costa", "Mesa" ], "output": "Costa Mesa" } }
{"index": {}}
{ "name" : "Inglewood", "suggest" : { "input": [ "Inglewood" ], "output": "Inglewood" } }
{"index": {}}
{ "name" : "Miami Gardens", "suggest" : { "input": [ "Miami", "Gardens" ], "output": "Miami Gardens" } }
{"index": {}}
{ "name" : "Manchester", "suggest" : { "input": [ "Manchester" ], "output": "Manchester" } }
{"index": {}}
{ "name" : "Elgin", "suggest" : { "input": [ "Elgin" ], "output": "Elgin" } }
{"index": {}}
{ "name" : "Wilmington", "suggest" : { "input": [ "Wilmington" ], "output": "Wilmington" } }
{"index": {}}
{ "name" : "Waterbury", "suggest" : { "input": [ "Waterbury" ], "output": "Waterbury" } }
{"index": {}}
{ "name" : "Fargo", "suggest" : { "input": [ "Fargo" ], "output": "Fargo" } }
{"index": {}}
{ "name" : "Arvada", "suggest" : { "input": [ "Arvada" ], "output": "Arvada" } }
{"index": {}}
{ "name" : "Carlsbad", "suggest" : { "input": [ "Carlsbad" ], "output": "Carlsbad" } }
{"index": {}}
{ "name" : "Westminster", "suggest" : { "input": [ "Westminster" ], "output": "Westminster" } }
{"index": {}}
{ "name" : "Rochester", "suggest" : { "input": [ "Rochester" ], "output": "Rochester" } }
{"index": {}}
{ "name" : "Gresham", "suggest" : { "input": [ "Gresham" ], "output": "Gresham" } }
{"index": {}}
{ "name" : "Clearwater", "suggest" : { "input": [ "Clearwater" ], "output": "Clearwater" } }
{"index": {}}
{ "name" : "Lowell", "suggest" : { "input": [ "Lowell" ], "output": "Lowell" } }
{"index": {}}
{ "name" : "West Jordan", "suggest" : { "input": [ "West", "Jordan" ], "output": "West Jordan" } }
{"index": {}}
{ "name" : "Pueblo", "suggest" : { "input": [ "Pueblo" ], "output": "Pueblo" } }
{"index": {}}
{ "name" : "San Buenaventura (Ventura)", "suggest" : { "input": [ "San Buenaventura", "(Ventura)" ], "output": "San Buenaventura (Ventura)" } }
{"index": {}}
{ "name" : "Fairfield", "suggest" : { "input": [ "Fairfield" ], "output": "Fairfield" } }
{"index": {}}
{ "name" : "West Covina", "suggest" : { "input": [ "West", "Covina" ], "output": "West Covina" } }
{"index": {}}
{ "name" : "Billings", "suggest" : { "input": [ "Billings" ], "output": "Billings" } }
{"index": {}}
{ "name" : "Murrieta", "suggest" : { "input": [ "Murrieta" ], "output": "Murrieta" } }
{"index": {}}
{ "name" : "High Point", "suggest" : { "input": [ "High", "Point" ], "output": "High Point" } }
{"index": {}}
{ "name" : "Round Rock", "suggest" : { "input": [ "Round", "Rock" ], "output": "Round Rock" } }
{"index": {}}
{ "name" : "Richmond", "suggest" : { "input": [ "Richmond" ], "output": "Richmond" } }
{"index": {}}
{ "name" : "Cambridge", "suggest" : { "input": [ "Cambridge" ], "output": "Cambridge" } }
{"index": {}}
{ "name" : "Norwalk", "suggest" : { "input": [ "Norwalk" ], "output": "Norwalk" } }
{"index": {}}
{ "name" : "Odessa", "suggest" : { "input": [ "Odessa" ], "output": "Odessa" } }
{"index": {}}
{ "name" : "Antioch", "suggest" : { "input": [ "Antioch" ], "output": "Antioch" } }
{"index": {}}
{ "name" : "Temecula", "suggest" : { "input": [ "Temecula" ], "output": "Temecula" } }
{"index": {}}
{ "name" : "Green Bay", "suggest" : { "input": [ "Green", "Bay" ], "output": "Green Bay" } }
{"index": {}}
{ "name" : "Everett", "suggest" : { "input": [ "Everett" ], "output": "Everett" } }
{"index": {}}
{ "name" : "Wichita Falls", "suggest" : { "input": [ "Wichita", "Falls" ], "output": "Wichita Falls" } }
{"index": {}}
{ "name" : "Burbank", "suggest" : { "input": [ "Burbank" ], "output": "Burbank" } }
{"index": {}}
{ "name" : "Palm Bay", "suggest" : { "input": [ "Palm", "Bay" ], "output": "Palm Bay" } }
{"index": {}}
{ "name" : "Centennial", "suggest" : { "input": [ "Centennial" ], "output": "Centennial" } }
{"index": {}}
{ "name" : "Daly City", "suggest" : { "input": [ "Daly", "City" ], "output": "Daly City" } }
{"index": {}}
{ "name" : "Richardson", "suggest" : { "input": [ "Richardson" ], "output": "Richardson" } }
{"index": {}}
{ "name" : "Pompano Beach", "suggest" : { "input": [ "Pompano", "Beach" ], "output": "Pompano Beach" } }
{"index": {}}
{ "name" : "Broken Arrow", "suggest" : { "input": [ "Broken", "Arrow" ], "output": "Broken Arrow" } }
{"index": {}}
{ "name" : "North Charleston", "suggest" : { "input": [ "North", "Charleston" ], "output": "North Charleston" } }
{"index": {}}
{ "name" : "West Palm Beach", "suggest" : { "input": [ "West Palm", "Beach" ], "output": "West Palm Beach" } }
{"index": {}}
{ "name" : "Boulder", "suggest" : { "input": [ "Boulder" ], "output": "Boulder" } }
{"index": {}}
{ "name" : "Rialto", "suggest" : { "input": [ "Rialto" ], "output": "Rialto" } }
{"index": {}}
{ "name" : "Santa Maria", "suggest" : { "input": [ "Santa", "Maria" ], "output": "Santa Maria" } }
{"index": {}}
{ "name" : "El Cajon", "suggest" : { "input": [ "El", "Cajon" ], "output": "El Cajon" } }
{"index": {}}
{ "name" : "Davenport", "suggest" : { "input": [ "Davenport" ], "output": "Davenport" } }
{"index": {}}
{ "name" : "Erie", "suggest" : { "input": [ "Erie" ], "output": "Erie" } }
{"index": {}}
{ "name" : "Las Cruces", "suggest" : { "input": [ "Las", "Cruces" ], "output": "Las Cruces" } }
{"index": {}}
{ "name" : "South Bend", "suggest" : { "input": [ "South", "Bend" ], "output": "South Bend" } }
{"index": {}}
{ "name" : "Flint", "suggest" : { "input": [ "Flint" ], "output": "Flint" } }
{"index": {}}
{ "name" : "Kenosha", "suggest" : { "input": [ "Kenosha" ], "output": "Kenosha" } }'
echo
curl -XPOST 'localhost:9200/test-idx/_refresh?pretty'

# Get 5 suggestions starting with "y"
curl -X POST 'localhost:9200/test-idx/_suggest?pretty' -d '{
    "city-suggest" : {
        "text" : "y",
        "completion" : {
            "field" : "suggest"
        }
    }
}'

# Get 10 suggestions starting with "a"
curl -X POST 'localhost:9200/test-idx/_suggest?pretty' -d '{ 
    "city-suggest" : { 
        "text" : "a", 
        "completion" : { 
            "field" : "suggest", 
            "size": 10 
        }
    } 
}'


