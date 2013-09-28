#!/bin/bash
curl -XDELETE 'http://localhost:9200/test-data/'
curl -XPUT 'http://localhost:9200/test-data/' -d '{
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
    "states": {
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
    "cities": {
      "_parent": {
        "type": "states"
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
          "type" : "double"
        },
        "population2012" : {
          "type" : "double"
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
curl -XPOST 'http://localhost:9200/_bulk'  --data-binary '{"index":{"_index":"test-data","_type":"states","_id":"AL"}}
{"abbreviation":"AL","state":"Alabama","capital":"Montgomery","nicknames":["Cotton State","Heart of Dixie","Yellow-hammer State"],"bird":"Yellowhammer","flower":"Camellia","tree":"Southern pine","motto":"Audemus jura nostra defendere (\"We dare defend our rights\")","song":"Alabama","land_area":"50645.33","water_area":"1774.74","total_area":"52420.07","status":"State","location":{"lat":"32.7396323","lon":"-86.8434593"}}
{"index":{"_index":"test-data","_type":"states","_id":"AK"}}
{"abbreviation":"AK","state":"Alaska","capital":"Juneau","nicknames":["Land of the Midnight Sun","The Last Frontier"],"bird":"Willow ptarmigan","flower":"Forget-me-not","tree":"Sitka spruce","motto":"North to the Future (unofficial)","song":"Alaska'\''s Flag","land_area":"570640.95","water_area":"94743.1","total_area":"665384.04","status":"State","location":{"lat":"63.346191","lon":"-152.8370679"}}
{"index":{"_index":"test-data","_type":"states","_id":"AZ"}}
{"abbreviation":"AZ","state":"Arizona","capital":"Phoenix","nicknames":["Grand Canyon State"],"bird":"Cactus wren","flower":"Saguaro cactus","tree":"Paloverde","motto":"Ditat Deus (\"God enriches\")","song":"Arizona","land_area":"113594.08","water_area":"396.22","total_area":"113990.3","status":"State","location":{"lat":"34.2099643","lon":"-111.602401"}}
{"index":{"_index":"test-data","_type":"states","_id":"AR"}}
{"abbreviation":"AR","state":"Arkansas","capital":"Little Rock","nicknames":["Land of Opportunity","The Natural State"],"bird":"Mockingbird","flower":"Apple blossom","tree":"Short-leaf pine","motto":"Regnat populus(\"The people rule\")","song":"Arkansas","land_area":"52035.48","water_area":"1143.07","total_area":"53178.55","status":"State","location":{"lat":"34.8955256","lon":"-92.4446262"}}
{"index":{"_index":"test-data","_type":"states","_id":"CA"}}
{"abbreviation":"CA","state":"California","capital":"Sacramento","nicknames":["Golden State"],"bird":"Valley quail","flower":"Golden poppy","tree":"Redwood","motto":"Eureka (\"I have found it\")","song":"I Love You, California","land_area":"155779.22","water_area":"7915.52","total_area":"163694.74","status":"State","location":{"lat":"37.148573","lon":"-119.5406515"}}
{"index":{"_index":"test-data","_type":"states","_id":"CO"}}
{"abbreviation":"CO","state":"Colorado","capital":"Denver","nicknames":["Centennial State"],"bird":"Lark bunting","flower":"Columbine","tree":"Blue spruce","motto":"Nil sine numine(\"Nothing without Providence\")","song":"Where the Columbines Grow","land_area":"103641.89","water_area":"451.78","total_area":"104093.67","status":"State","location":{"lat":"38.9935752","lon":"-105.5077737"}}
{"index":{"_index":"test-data","_type":"states","_id":"CT"}}
{"abbreviation":"CT","state":"Connecticut","capital":"Hartford","nicknames":["Constitution State","Nutmeg State"],"bird":"American robin","flower":"Mountain laurel","tree":"White oak","motto":"Qui transtulit sustinet (\"He who transplanted still sustains\")","song":"(none)","land_area":"4842.36","water_area":"701.06","total_area":"5543.41","status":"State","location":{"lat":"41.5797842","lon":"-72.7466666"}}
{"index":{"_index":"test-data","_type":"states","_id":"DE"}}
{"abbreviation":"DE","state":"Delaware","capital":"Dover","nicknames":["Diamond State","First State"],"bird":"Blue hen chicken","flower":"Peach blossom","tree":"American holly","motto":"Liberty and Independence","song":"Our Delaware","land_area":"1948.54","water_area":"540.18","total_area":"2488.72","status":"State","location":{"lat":"38.9935501","lon":"-75.4473739"}}
{"index":{"_index":"test-data","_type":"states","_id":"DC"}}
{"abbreviation":"DC","state":"District of Columbia","capital":"Washington","nicknames":["D.C."],"bird":"Wood Thrush","flower":"American Beauty Rose","tree":"Scarlet Oak","motto":"Justia Omnibus - Justice for All","song":"The Star-Spangled Banner","land_area":"61.05","water_area":"7.29","total_area":"68.34","status":"Federal Distirict","location":{"lat":"38.9041485","lon":"-77.0170942"}}
{"index":{"_index":"test-data","_type":"states","_id":"FL"}}
{"abbreviation":"FL","state":"Florida","capital":"Tallahassee","nicknames":["Sunshine State","Peninsula State"],"bird":"Mockingbird","flower":"Orange blossom","tree":"Sabal palm","motto":"In God We Trust","song":"The Swanee River (Old Folks at Home)","land_area":"53624.76","water_area":"12132.94","total_area":"65757.7","status":"State","location":{"lat":"28.4574302","lon":"-82.4091478"}}
{"index":{"_index":"test-data","_type":"states","_id":"GA"}}
{"abbreviation":"GA","state":"Georgia","capital":"Atlanta","nicknames":["Empire State of the South","Peach State"],"bird":"Brown thrasher","flower":"Cherokee rose","tree":"Live oak","motto":"Wisdom, Justice, Moderation","song":"Georgia on My Mind","land_area":"57513.49","water_area":"1911.67","total_area":"59425.15","status":"State","location":{"lat":"32.629384","lon":"-83.4232125"}}
{"index":{"_index":"test-data","_type":"states","_id":"HI"}}
{"abbreviation":"HI","state":"Hawaii","capital":"Honolulu","nicknames":["Aloha State","Paradise of the Pacific"],"bird":"Hawaiian goose (nene)","flower":"Hibiscus (Pua Aloalo)","tree":"Candlenut (Kukui)","motto":"Ua mau ke ea o ka aina i ka pono (\"The life of the land is perpetuated in righteousness\")","song":"Hawaii Ponoi","land_area":"6422.63","water_area":"4509.09","total_area":"10931.72","status":"State","location":{"lat":"19.809767","lon":"-155.5061027"}}
{"index":{"_index":"test-data","_type":"states","_id":"ID"}}
{"abbreviation":"ID","state":"Idaho","capital":"Boise","nicknames":["Gem State"],"bird":"Mountain bluebird","flower":"Syringa","tree":"White pine","motto":"Esto perpetua(\"May she endure forever\")","song":"Here We Have Idaho","land_area":"82643.12","water_area":"925.83","total_area":"83568.95","status":"State","location":{"lat":"44.3020948","lon":"-114.5956254"}}
{"index":{"_index":"test-data","_type":"states","_id":"IL"}}
{"abbreviation":"IL","state":"Illinois","capital":"Springfield","nicknames":["Prairie State"],"bird":"Cardinal","flower":"Butterfly violet","tree":"White oak","motto":"State Sovereignty, National Union","song":"Illinois","land_area":"55518.93","water_area":"2394.62","total_area":"57913.55","status":"State","location":{"lat":"40.1028754","lon":"-89.1526108"}}
{"index":{"_index":"test-data","_type":"states","_id":"IN"}}
{"abbreviation":"IN","state":"Indiana","capital":"Indianapolis","nicknames":["Hoosier State"],"bird":"Cardinal","flower":"Peony","tree":"Tulip tree","motto":"Crossroads of America","song":"On the Banks of the Wabash Far Away","land_area":"35826.11","water_area":"593.44","total_area":"36419.55","status":"State","location":{"lat":"39.9030256","lon":"-86.2839503"}}
{"index":{"_index":"test-data","_type":"states","_id":"IA"}}
{"abbreviation":"IA","state":"Iowa","capital":"Des Moines","nicknames":["Hawkeye State"],"bird":"Eastern goldfinch","flower":"Carolina wild rose","tree":"Oak","motto":"Our Liberties We Prize and Our Rights We Will Maintain","song":"The Song of Iowa","land_area":"55857.13","water_area":"415.68","total_area":"56272.81","status":"State","location":{"lat":"42.0700243","lon":"-93.4933473"}}
{"index":{"_index":"test-data","_type":"states","_id":"KS"}}
{"abbreviation":"KS","state":"Kansas","capital":"Topeka","nicknames":["Jayhawker State","Sunflower State"],"bird":"Western meadowlark","flower":"Sunflower","tree":"Cottonwood","motto":"Ad astra per aspera (\"To the stars through difficulties\")","song":"Home on the Range","land_area":"81758.72","water_area":"519.64","total_area":"82278.36","status":"State","location":{"lat":"38.4985464","lon":"-98.3834298"}}
{"index":{"_index":"test-data","_type":"states","_id":"KY"}}
{"abbreviation":"KY","state":"Kentucky","capital":"Frankfort","nicknames":["Bluegrass State"],"bird":"Cardinal","flower":"Goldenrod","tree":"Tulip poplar","motto":"United We Stand, Divided We Fall","song":"My Old Kentucky Home","land_area":"39486.34","water_area":"921.46","total_area":"40407.8","status":"State","location":{"lat":"37.5336807","lon":"-85.2929841"}}
{"index":{"_index":"test-data","_type":"states","_id":"LA"}}
{"abbreviation":"LA","state":"Louisiana","capital":"Baton Rouge","nicknames":["Creole State","Pelican State"],"bird":"Pelican","flower":"Magnolia","tree":"Bald cypress","motto":"Union, Justice, and Confidence","song":"Give Me Louisiana; You Are My Sunshine","land_area":"43203.9","water_area":"9174.23","total_area":"52378.13","status":"State","location":{"lat":"30.8577705","lon":"-91.803273"}}
{"index":{"_index":"test-data","_type":"states","_id":"ME"}}
{"abbreviation":"ME","state":"Maine","capital":"Augusta","nicknames":["Lumber State","Pine Tree State"],"bird":"Chickadee","flower":"Pine cone and tassel","tree":"White pine","motto":"Dirigo (\"I lead\")","song":"State of Maine Song","land_area":"30842.92","water_area":"4536.82","total_area":"35379.74","status":"State","location":{"lat":"45.3906022","lon":"-68.6574869"}}
{"index":{"_index":"test-data","_type":"states","_id":"MD"}}
{"abbreviation":"MD","state":"Maryland","capital":"Annapolis","nicknames":["Old Line State"],"bird":"Baltimore oriole","flower":"Black-eyed Susan","tree":"White oak","motto":"Fatti maschii, parole femine(\"Manly deeds, womanly words\")","song":"Maryland, My Maryland","land_area":"9707.24","water_area":"2698.69","total_area":"12405.93","status":"State","location":{"lat":"38.9466584","lon":"-76.6744939"}}
{"index":{"_index":"test-data","_type":"states","_id":"MA"}}
{"abbreviation":"MA","state":"Massachusetts","capital":"Boston","nicknames":["Bay State","Old Bay State","Old Colony State"],"bird":"Chickadee","flower":"Mayflower","tree":"American elm","motto":"Ense petit placidam sub libertate quietem(\"By the sword she seeks peace under liberty\")","song":"Massachusetts","land_area":"7800.06","water_area":"2754.33","total_area":"10554.39","status":"State","location":{"lat":"42.1565196","lon":"-71.4895915"}}
{"index":{"_index":"test-data","_type":"states","_id":"MI"}}
{"abbreviation":"MI","state":"Michigan","capital":"Lansing","nicknames":["Wolverine State"],"bird":"Robin","flower":"Apple blossom","tree":"White pine","motto":"Si quaeris peninsulam amoenam circumspice (\"If you seek a pleasant peninsula, look about you\")","song":"Michigan, My Michigan(unofficial)","land_area":"56538.9","water_area":"40174.61","total_area":"96713.51","status":"State","location":{"lat":"44.8410835","lon":"-85.6593197"}}
{"index":{"_index":"test-data","_type":"states","_id":"MN"}}
{"abbreviation":"MN","state":"Minnesota","capital":"St. Paul","nicknames":["Gopher State","North Star State"],"bird":"Loon","flower":"Pink and white lady'\''s slipper","tree":"Red or Norway pine","motto":"L'\''Etoile du Nord(\"The North Star\")","song":"Hail! Minnesota","land_area":"79626.74","water_area":"7309.09","total_area":"86935.83","status":"State","location":{"lat":"46.3161343","lon":"-94.1994801"}}
{"index":{"_index":"test-data","_type":"states","_id":"MS"}}
{"abbreviation":"MS","state":"Mississippi","capital":"Jackson","nicknames":["Magnolia State"],"bird":"Mockingbird","flower":"Magnolia","tree":"Magnolia","motto":"Virtute et armis(\"By Valor and Arms\")","song":"Go, Mississippi","land_area":"46923.27","water_area":"1508.5","total_area":"48431.78","status":"State","location":{"lat":"32.6864655","lon":"-89.6561493"}}
{"index":{"_index":"test-data","_type":"states","_id":"MO"}}
{"abbreviation":"MO","state":"Missouri","capital":"Jefferson City","nicknames":["Show Me State"],"bird":"Bluebird","flower":"Hawthorn","tree":"Dogwood","motto":"Sclus populi suprema lex esto(\"Let the welfare of the people be the supreme law\")","song":"Missouri Waltz","land_area":"68741.52","water_area":"965.47","total_area":"69706.99","status":"State","location":{"lat":"38.35075","lon":"-92.4567826"}}
{"index":{"_index":"test-data","_type":"states","_id":"MT"}}
{"abbreviation":"MT","state":"Montana","capital":"Helena","nicknames":["Treasure State"],"bird":"Western meadowlark","flower":"Bitterroot","tree":"Ponderosa pine","motto":"Oro y plata(\"Gold and silver\")","song":"Montana","land_area":"145545.8","water_area":"1493.91","total_area":"147039.71","status":"State","location":{"lat":"47.0511771","lon":"-109.6348174"}}
{"index":{"_index":"test-data","_type":"states","_id":"NE"}}
{"abbreviation":"NE","state":"Nebraska","capital":"Lincoln","nicknames":["Cornhusker State"],"bird":"Western meadowlark","flower":"Goldenrod","tree":"Cottonwood","motto":"Equality Before the Law","song":"Beautiful Nebraska","land_area":"76824.17","water_area":"523.64","total_area":"77347.81","status":"State","location":{"lat":"41.5438105","lon":"-99.8123253"}}
{"index":{"_index":"test-data","_type":"states","_id":"NV"}}
{"abbreviation":"NV","state":"Nevada","capital":"Carson City","nicknames":["Sagebrush State","Silver State"],"bird":"Mountain bluebird","flower":"Sagebrush","tree":"Single-leaf pinon; Bristlecone pine","motto":"All For Our Country","song":"Home Means Nevada","land_area":"109781.18","water_area":"790.65","total_area":"110571.82","status":"State","location":{"lat":"39.3310928","lon":"-116.6151469"}}
{"index":{"_index":"test-data","_type":"states","_id":"NH"}}
{"abbreviation":"NH","state":"New Hampshire","capital":"Concord","nicknames":["Granite State"],"bird":"Purple finch","flower":"Purple lilac","tree":"White birch","motto":"Live Free or Die","song":"Old New Hampshire","land_area":"8952.65","water_area":"396.51","total_area":"9349.16","status":"State","location":{"lat":"43.6708595","lon":"-71.5811278"}}
{"index":{"_index":"test-data","_type":"states","_id":"NJ"}}
{"abbreviation":"NJ","state":"New Jersey","capital":"Trenton","nicknames":["Garden State"],"bird":"Eastern goldfinch","flower":"Purple violet","tree":"Red oak","motto":"Liberty and Prosperity","song":"(none)","land_area":"7354.22","water_area":"1368.36","total_area":"8722.58","status":"State","location":{"lat":"40.1072744","lon":"-74.6652012"}}
{"index":{"_index":"test-data","_type":"states","_id":"NM"}}
{"abbreviation":"NM","state":"New Mexico","capital":"Santa Fe","nicknames":["Land of Enchantment","Sunshine State"],"bird":"Roadrunner","flower":"Yucca","tree":"Pinon (nut pine)","motto":"Crescit eundo (\"It grows as it goes\")","song":"O Fair New Mexico","land_area":"121298.15","water_area":"292.15","total_area":"121590.3","status":"State","location":{"lat":"34.4391265","lon":"-106.1261511"}}
{"index":{"_index":"test-data","_type":"states","_id":"NY"}}
{"abbreviation":"NY","state":"New York","capital":"Albany","nicknames":["Empire State"],"bird":"Eastern bluebird","flower":"Rose","tree":"Sugar maple","motto":"Excelsior (\"Ever upward\")","song":"(none)","land_area":"47126.4","water_area":"7428.58","total_area":"54554.98","status":"State","location":{"lat":"42.9133974","lon":"-75.5962723"}}
{"index":{"_index":"test-data","_type":"states","_id":"NC"}}
{"abbreviation":"NC","state":"North Carolina","capital":"Raleigh","nicknames":["Old North State","Tar Heel State"],"bird":"Cardinal","flower":"Dogwood","tree":"Pine","motto":"Esse quam videri(\"To be, rather than to seem\")","song":"The Old North State","land_area":"48617.91","water_area":"5201.25","total_area":"53819.16","status":"State","location":{"lat":"35.53971","lon":"-79.1308636"}}
{"index":{"_index":"test-data","_type":"states","_id":"ND"}}
{"abbreviation":"ND","state":"North Dakota","capital":"Bismarck","nicknames":["Flickertail State","Sioux State"],"bird":"Western meadowlark","flower":"Prairie rose","tree":"American elm","motto":"Liberty and Union, Now and Forever, One and Inseparable","song":"North Dakota Hymn","land_area":"69000.8","water_area":"1697.52","total_area":"70698.32","status":"State","location":{"lat":"47.4569538","lon":"-100.4619304"}}
{"index":{"_index":"test-data","_type":"states","_id":"OH"}}
{"abbreviation":"OH","state":"Ohio","capital":"Columbus","nicknames":["Buckeye State"],"bird":"Cardinal","flower":"Scarlet carnation","tree":"Buckeye","motto":"With God All Things Are Possible","song":"Beautiful Ohio","land_area":"40860.69","water_area":"3964.89","total_area":"44825.58","status":"State","location":{"lat":"40.4149297","lon":"-82.7119975"}}
{"index":{"_index":"test-data","_type":"states","_id":"OK"}}
{"abbreviation":"OK","state":"Oklahoma","capital":"Oklahoma City","nicknames":["Sooner State"],"bird":"Scissor-tailed flycatcher","flower":"Mistletoe","tree":"Redbud","motto":"Labor omnia vincit(\"Labor conquers all things\")","song":"Oklahoma!","land_area":"68594.92","water_area":"1303.95","total_area":"69898.87","status":"State","location":{"lat":"35.5894185","lon":"-97.4868683"}}
{"index":{"_index":"test-data","_type":"states","_id":"OR"}}
{"abbreviation":"OR","state":"Oregon","capital":"Salem","nicknames":["Beaver State"],"bird":"Western meadowlark","flower":"Oregon grape","tree":"Douglas fir","motto":"She Flies With Her Own Wings","song":"Oregon, My Oregon","land_area":"95988.01","water_area":"2390.53","total_area":"98378.54","status":"State","location":{"lat":"43.9715225","lon":"-120.6226269"}}
{"index":{"_index":"test-data","_type":"states","_id":"PA"}}
{"abbreviation":"PA","state":"Pennsylvania","capital":"Harrisburg","nicknames":["Keystone State"],"bird":"Ruffed grouse","flower":"Mountain laurel","tree":"Eastern hemlock","motto":"Virtue, Liberty, and Independence","song":"(none)","land_area":"44742.7","water_area":"1311.64","total_area":"46054.34","status":"State","location":{"lat":"40.9042486","lon":"-77.8280624"}}
{"index":{"_index":"test-data","_type":"states","_id":"RI"}}
{"abbreviation":"RI","state":"Rhode Island","capital":"Providence","nicknames":["Little Rhody"],"bird":"Rhode Island red","flower":"Violet","tree":"Red maple","motto":"Hope","song":"Rhode Island'\''s It for Me","land_area":"1033.81","water_area":"511.07","total_area":"1544.89","status":"State","location":{"lat":"41.5978358","lon":"-71.5252895"}}
{"index":{"_index":"test-data","_type":"states","_id":"SC"}}
{"abbreviation":"SC","state":"South Carolina","capital":"Columbia","nicknames":["Palmetto State"],"bird":"Carolina wren","flower":"Carolina jessamine","tree":"Palmetto","motto":"Animis opibusque parati (\"Prepared in mind and resources\") andDum spiro spero(\"While I breathe, I hope\")","song":"Carolina","land_area":"30060.7","water_area":"1959.79","total_area":"32020.49","status":"State","location":{"lat":"33.8741769","lon":"-80.8542699"}}
{"index":{"_index":"test-data","_type":"states","_id":"SD"}}
{"abbreviation":"SD","state":"South Dakota","capital":"Pierre","nicknames":["Coyote State","Sunshine State"],"bird":"Ring-necked pheasant","flower":"Pasqueflower","tree":"Black Hills spruce","motto":"Under God the People Rule","song":"Hail, South Dakota","land_area":"75811","water_area":"1304.68","total_area":"77115.68","status":"State","location":{"lat":"44.4467957","lon":"-100.2381762"}}
{"index":{"_index":"test-data","_type":"states","_id":"TN"}}
{"abbreviation":"TN","state":"Tennessee","capital":"Nashville","nicknames":["Volunteer State"],"bird":"Mockingbird","flower":"Iris","tree":"Tulip poplar","motto":"Agriculture and Commerce","song":"Tennessee Waltz","land_area":"41234.9","water_area":"909.36","total_area":"42144.25","status":"State","location":{"lat":"35.8585639","lon":"-86.3493573"}}
{"index":{"_index":"test-data","_type":"states","_id":"TX"}}
{"abbreviation":"TX","state":"Texas","capital":"Austin","nicknames":["Lone Star State"],"bird":"Mockingbird","flower":"Bluebonnet","tree":"Pecan","motto":"Friendship","song":"Texas, Our Texas","land_area":"261231.71","water_area":"7364.75","total_area":"268596.46","status":"State","location":{"lat":"31.4347032","lon":"-99.2818238"}}
{"index":{"_index":"test-data","_type":"states","_id":"UT"}}
{"abbreviation":"UT","state":"Utah","capital":"Salt Lake City","nicknames":["Beehive State"],"bird":"Sea gull","flower":"Sego lily","tree":"Blue spruce","motto":"Industry","song":"Utah, We Love Thee","land_area":"82169.62","water_area":"2727.26","total_area":"84896.88","status":"State","location":{"lat":"39.3349735","lon":"-111.6563633"}}
{"index":{"_index":"test-data","_type":"states","_id":"VT"}}
{"abbreviation":"VT","state":"Vermont","capital":"Montpelier","nicknames":["Green Mountain State"],"bird":"Hermit thrush","flower":"Red clover","tree":"Sugar maple","motto":"Freedom and Unity","song":"Hail, Vermont","land_area":"9216.66","water_area":"399.71","total_area":"9616.36","status":"State","location":{"lat":"44.0605475","lon":"-72.673354"}}
{"index":{"_index":"test-data","_type":"states","_id":"VA"}}
{"abbreviation":"VA","state":"Virginia","capital":"Richmond","nicknames":["Old Dominion"],"bird":"Cardinal","flower":"American dogwood","tree":"American dogwood","motto":"Sic semper tyrannis (\"Thus always to tyrants\")","song":"Carry Me Back to Old Virginia","land_area":"39490.09","water_area":"3284.84","total_area":"42774.93","status":"State","location":{"lat":"37.5222512","lon":"-78.6681938"}}
{"index":{"_index":"test-data","_type":"states","_id":"WA"}}
{"abbreviation":"WA","state":"Washington","capital":"Olympia","nicknames":["Evergreen State","Chinook State"],"bird":"Willow goldfinch","flower":"Rhododendron","tree":"Western hemlock","motto":"Al-ki (\"By and by\")","song":"Washington, My Home","land_area":"66455.52","water_area":"4842.43","total_area":"71297.95","status":"State","location":{"lat":"47.4162296","lon":"-120.5996231"}}
{"index":{"_index":"test-data","_type":"states","_id":"WV"}}
{"abbreviation":"WV","state":"West Virginia","capital":"Charleston","nicknames":["Mountain State"],"bird":"Cardinal","flower":"Rosebay rhododendron","tree":"Sugar maple","motto":"Montani semper liberi(\"Mountaineers are always free men\")","song":"The West Virginia Hills and West Virginia, My Home, Sweet Home","land_area":"24038.21","water_area":"191.83","total_area":"24230.04","status":"State","location":{"lat":"38.6472854","lon":"-80.6183274"}}
{"index":{"_index":"test-data","_type":"states","_id":"WI"}}
{"abbreviation":"WI","state":"Wisconsin","capital":"Madison","nicknames":["Badger State"],"bird":"Robin","flower":"Butterfly violet","tree":"Sugar maple","motto":"Forward","song":"On, Wisconsin!","land_area":"54157.8","water_area":"11338.57","total_area":"65496.38","status":"State","location":{"lat":"44.628484","lon":"-89.7119299"}}
{"index":{"_index":"test-data","_type":"states","_id":"WY"}}
{"abbreviation":"WY","state":"Wyoming","capital":"Cheyenne","nicknames":["Equality State"],"bird":"Western meadowlark","flower":"Indian paintbrush","tree":"Cottonwood","motto":"Equal Rights","song":"Wyoming","land_area":"97093.14","water_area":"719.87","total_area":"97813.01","status":"State","location":{"lat":"42.9918024","lon":"-107.5419255"}}
'
echo
curl -XPOST 'http://localhost:9200/_bulk'  --data-binary '{"index":{"_index":"test-data","_type":"cities","_id":"1","_parent":"NY"}}
{"rank":"1","city":"New York","state":"New York","population2012":"8336697","population2010":"8175133","land_area":"302.643","density":"27012","ansi":"2395220","location":{"lat":"40.6643","lon":"73.9385"},"abbreviation":"NY"}
{"index":{"_index":"test-data","_type":"cities","_id":"2","_parent":"CA"}}
{"rank":"2","city":"Los Angeles","state":"California","population2012":"3857799","population2010":"3792621","land_area":"468.670","density":"8092","ansi":"2410877","location":{"lat":"34.0194","lon":"118.4108"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"3","_parent":"IL"}}
{"rank":"3","city":"Chicago","state":"Illinois","population2012":"2714856","population2010":"2695598","land_area":"227.635","density":"11842","ansi":"428803","location":{"lat":"41.8376","lon":"87.6818"},"abbreviation":"IL"}
{"index":{"_index":"test-data","_type":"cities","_id":"4","_parent":"TX"}}
{"rank":"4","city":"Houston","state":"Texas","population2012":"2160821","population2010":"2100263","land_area":"599.589","density":"3501","ansi":"2410796","location":{"lat":"29.7805","lon":"95.3863"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"5","_parent":"PA"}}
{"rank":"5","city":"Philadelphia","state":"Pennsylvania","population2012":"1547607","population2010":"1526006","land_area":"134.101","density":"11379","ansi":"1215531","location":{"lat":"40.0094","lon":"75.1333"},"abbreviation":"PA"}
{"index":{"_index":"test-data","_type":"cities","_id":"6","_parent":"AZ"}}
{"rank":"6","city":"Phoenix","state":"Arizona","population2012":"1488750","population2010":"1445632","land_area":"516.704","density":"2798","ansi":"2411414","location":{"lat":"33.5722","lon":"112.088"},"abbreviation":"AZ"}
{"index":{"_index":"test-data","_type":"cities","_id":"7","_parent":"TX"}}
{"rank":"7","city":"San Antonio","state":"Texas","population2012":"1382951","population2010":"1327407","land_area":"460.933","density":"2880","ansi":"2411774","location":{"lat":"29.4724","lon":"98.5251"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"8","_parent":"CA"}}
{"rank":"8","city":"San Diego","state":"California","population2012":"1338348","population2010":"1307402","land_area":"325.188","density":"4020","ansi":"2411782","location":{"lat":"32.8153","lon":"117.135"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"9","_parent":"TX"}}
{"rank":"9","city":"Dallas","state":"Texas","population2012":"1241162","population2010":"1197816","land_area":"340.519","density":"3518","ansi":"2410288","location":{"lat":"32.7757","lon":"96.7967"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"10","_parent":"CA"}}
{"rank":"10","city":"San Jose","state":"California","population2012":"982765","population2010":"945942","land_area":"176.526","density":"5359","ansi":"2411790","location":{"lat":"37.2969","lon":"121.8193"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"11","_parent":"TX"}}
{"rank":"11","city":"Austin","state":"Texas","population2012":"842592","population2010":"790390","land_area":"297.896","density":"2653","ansi":"2409761","location":{"lat":"30.3072","lon":"97.756"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"12","_parent":"FL"}}
{"rank":"12","city":"Jacksonville","state":"Florida","population2012":"836507","population2010":"821784","land_area":"747.003","density":"1100","ansi":"2404783","location":{"lat":"30.337","lon":"81.6613"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"13","_parent":"IN"}}
{"rank":"13","city":"Indianapolis","state":"Indiana","population2012":"834852","population2010":"820445","land_area":"361.433","density":"2270","ansi":"2395424","location":{"lat":"39.7767","lon":"86.1459"},"abbreviation":"IN"}
{"index":{"_index":"test-data","_type":"cities","_id":"14","_parent":"CA"}}
{"rank":"14","city":"San Francisco","state":"California","population2012":"825863","population2010":"805235","land_area":"46.873","density":"17179","ansi":"2411786","location":{"lat":"37.7272","lon":"123.0322"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"15","_parent":"OH"}}
{"rank":"15","city":"Columbus","state":"Ohio","population2012":"809798","population2010":"787033","land_area":"217.169","density":"3624","ansi":"1086101","location":{"lat":"39.9848","lon":"82.985"},"abbreviation":"OH"}
{"index":{"_index":"test-data","_type":"cities","_id":"16","_parent":"TX"}}
{"rank":"16","city":"Fort Worth","state":"Texas","population2012":"777992","population2010":"741206","land_area":"339.819","density":"2181","ansi":"2410531","location":{"lat":"32.7795","lon":"97.3463"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"17","_parent":"NC"}}
{"rank":"17","city":"Charlotte","state":"North Carolina","population2012":"775202","population2010":"731424","land_area":"297.678","density":"2457","ansi":"2404032","location":{"lat":"35.2087","lon":"80.8307"},"abbreviation":"NC"}
{"index":{"_index":"test-data","_type":"cities","_id":"18","_parent":"MI"}}
{"rank":"18","city":"Detroit","state":"Michigan","population2012":"701475","population2010":"713777","land_area":"138.750","density":"5144","ansi":"1626181","location":{"lat":"42.383","lon":"83.1022"},"abbreviation":"MI"}
{"index":{"_index":"test-data","_type":"cities","_id":"19","_parent":"TX"}}
{"rank":"19","city":"El Paso","state":"Texas","population2012":"672538","population2010":"649121","land_area":"255.235","density":"2543","ansi":"2410414","location":{"lat":"31.8484","lon":"106.427"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"20","_parent":"TN"}}
{"rank":"20","city":"Memphis","state":"Tennessee","population2012":"655155","population2010":"646889","land_area":"315.055","density":"2053","ansi":"2405068","location":{"lat":"35.1035","lon":"89.9785"},"abbreviation":"TN"}
{"index":{"_index":"test-data","_type":"cities","_id":"21","_parent":"MA"}}
{"rank":"21","city":"Boston","state":"Massachusetts","population2012":"636479","population2010":"617594","land_area":"48.277","density":"12793","ansi":"619463","location":{"lat":"42.332","lon":"71.0202"},"abbreviation":"MA"}
{"index":{"_index":"test-data","_type":"cities","_id":"22","_parent":"WA"}}
{"rank":"22","city":"Seattle","state":"Washington","population2012":"634535","population2010":"608660","land_area":"83.943","density":"7251","ansi":"2411856","location":{"lat":"47.6205","lon":"122.3509"},"abbreviation":"WA"}
{"index":{"_index":"test-data","_type":"cities","_id":"23","_parent":"CO"}}
{"rank":"23","city":"Denver","state":"Colorado","population2012":"634265","population2010":"600158","land_area":"153.000","density":"3923","ansi":"2410324","location":{"lat":"39.7618","lon":"104.8806"},"abbreviation":"CO"}
{"index":{"_index":"test-data","_type":"cities","_id":"24","_parent":"DC"}}
{"rank":"24","city":"Washington","state":"District of Columbia","population2012":"632323","population2010":"601723","land_area":"61.048","density":"9856","ansi":"2390665","location":{"lat":"38.9041","lon":"77.0171"},"abbreviation":"DC"}
{"index":{"_index":"test-data","_type":"cities","_id":"25","_parent":"TN"}}
{"rank":"25","city":"Nashville","state":"Tennessee","population2012":"624496","population2010":"601222","land_area":"475.126","density":"1265","ansi":"2405092","location":{"lat":"36.1718","lon":"86.785"},"abbreviation":"TN"}
{"index":{"_index":"test-data","_type":"cities","_id":"26","_parent":"MD"}}
{"rank":"26","city":"Baltimore","state":"Maryland","population2012":"621342","population2010":"620961","land_area":"80.944","density":"7672","ansi":"1702381","location":{"lat":"39.3002","lon":"76.6105"},"abbreviation":"MD"}
{"index":{"_index":"test-data","_type":"cities","_id":"27","_parent":"KY"}}
{"rank":"27","city":"Louisville","state":"Kentucky","population2012":"605110","population2010":"597337","land_area":"325.248","density":"1837","ansi":"1967434","location":{"lat":"38.1781","lon":"85.6667"},"abbreviation":"KY"}
{"index":{"_index":"test-data","_type":"cities","_id":"28","_parent":"OR"}}
{"rank":"28","city":"Portland","state":"Oregon","population2012":"603106","population2010":"583776","land_area":"133.427","density":"4375","ansi":"2411471","location":{"lat":"45.537","lon":"122.65"},"abbreviation":"OR"}
{"index":{"_index":"test-data","_type":"cities","_id":"29","_parent":"OK"}}
{"rank":"29","city":"Oklahoma City","state":"Oklahoma","population2012":"599199","population2010":"579999","land_area":"606.410","density":"956","ansi":"2411311","location":{"lat":"35.4671","lon":"97.5137"},"abbreviation":"OK"}
{"index":{"_index":"test-data","_type":"cities","_id":"30","_parent":"WI"}}
{"rank":"30","city":"Milwaukee","state":"Wisconsin","population2012":"598916","population2010":"594833","land_area":"96.122","density":"6188","ansi":"1583724","location":{"lat":"43.0633","lon":"87.9667"},"abbreviation":"WI"}
{"index":{"_index":"test-data","_type":"cities","_id":"31","_parent":"NV"}}
{"rank":"31","city":"Las Vegas","state":"Nevada","population2012":"596424","population2010":"583756","land_area":"135.815","density":"4298","ansi":"2411630","location":{"lat":"36.2277","lon":"115.264"},"abbreviation":"NV"}
{"index":{"_index":"test-data","_type":"cities","_id":"32","_parent":"NM"}}
{"rank":"32","city":"Albuquerque","state":"New Mexico","population2012":"555417","population2010":"545852","land_area":"187.730","density":"2908","ansi":"2409678","location":{"lat":"35.1056","lon":"106.6474"},"abbreviation":"NM"}
{"index":{"_index":"test-data","_type":"cities","_id":"33","_parent":"AZ"}}
{"rank":"33","city":"Tucson","state":"Arizona","population2012":"524295","population2010":"520116","land_area":"226.709","density":"2294","ansi":"2412104","location":{"lat":"32.1543","lon":"110.8711"},"abbreviation":"AZ"}
{"index":{"_index":"test-data","_type":"cities","_id":"34","_parent":"CA"}}
{"rank":"34","city":"Fresno","state":"California","population2012":"505882","population2010":"494665","land_area":"111.957","density":"4418","ansi":"2410546","location":{"lat":"36.7827","lon":"119.7945"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"35","_parent":"CA"}}
{"rank":"35","city":"Sacramento","state":"California","population2012":"475516","population2010":"466488","land_area":"97.915","density":"4764","ansi":"2411751","location":{"lat":"38.5666","lon":"121.4686"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"36","_parent":"CA"}}
{"rank":"36","city":"Long Beach","state":"California","population2012":"467892","population2010":"462257","land_area":"50.293","density":"9191","ansi":"2410866","location":{"lat":"33.8091","lon":"118.1553"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"37","_parent":"MO"}}
{"rank":"37","city":"Kansas City","state":"Missouri","population2012":"464310","population2010":"459787","land_area":"314.950","density":"1460","ansi":"2395492","location":{"lat":"39.1252","lon":"94.5511"},"abbreviation":"MO"}
{"index":{"_index":"test-data","_type":"cities","_id":"38","_parent":"AZ"}}
{"rank":"38","city":"Mesa","state":"Arizona","population2012":"452084","population2010":"439041","land_area":"136.452","density":"3218","ansi":"2411087","location":{"lat":"33.4019","lon":"111.7174"},"abbreviation":"AZ"}
{"index":{"_index":"test-data","_type":"cities","_id":"39","_parent":"VA"}}
{"rank":"39","city":"Virginia Beach","state":"Virginia","population2012":"447021","population2010":"437994","land_area":"249.016","density":"1759","ansi":"1498559","location":{"lat":"36.7793","lon":"76.024"},"abbreviation":"VA"}
{"index":{"_index":"test-data","_type":"cities","_id":"40","_parent":"GA"}}
{"rank":"40","city":"Atlanta","state":"Georgia","population2012":"443775","population2010":"420003","land_area":"133.152","density":"3154","ansi":"2403126","location":{"lat":"33.7629","lon":"84.4227"},"abbreviation":"GA"}
{"index":{"_index":"test-data","_type":"cities","_id":"41","_parent":"CO"}}
{"rank":"41","city":"Colorado Springs","state":"Colorado","population2012":"431834","population2010":"416427","land_area":"194.540","density":"2141","ansi":"2410198","location":{"lat":"38.8673","lon":"104.7607"},"abbreviation":"CO"}
{"index":{"_index":"test-data","_type":"cities","_id":"42","_parent":"NC"}}
{"rank":"42","city":"Raleigh","state":"North Carolina","population2012":"423179","population2010":"403892","land_area":"142.903","density":"2826","ansi":"2404590","location":{"lat":"35.8302","lon":"78.6414"},"abbreviation":"NC"}
{"index":{"_index":"test-data","_type":"cities","_id":"43","_parent":"NE"}}
{"rank":"43","city":"Omaha","state":"Nebraska","population2012":"421570","population2010":"408958","land_area":"127.088","density":"3218","ansi":"2396064","location":{"lat":"41.2647","lon":"96.0419"},"abbreviation":"NE"}
{"index":{"_index":"test-data","_type":"cities","_id":"44","_parent":"FL"}}
{"rank":"44","city":"Miami","state":"Florida","population2012":"413892","population2010":"399457","land_area":"35.871","density":"11136","ansi":"2404247","location":{"lat":"25.7752","lon":"80.2086"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"45","_parent":"CA"}}
{"rank":"45","city":"Oakland","state":"California","population2012":"400740","population2010":"390724","land_area":"55.786","density":"7004","ansi":"2411292","location":{"lat":"37.7699","lon":"122.2256"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"46","_parent":"OK"}}
{"rank":"46","city":"Tulsa","state":"Oklahoma","population2012":"393987","population2010":"391906","land_area":"196.754","density":"1992","ansi":"2412110","location":{"lat":"36.1279","lon":"95.9023"},"abbreviation":"OK"}
{"index":{"_index":"test-data","_type":"cities","_id":"47","_parent":"MN"}}
{"rank":"47","city":"Minneapolis","state":"Minnesota","population2012":"392880","population2010":"382578","land_area":"53.973","density":"7088","ansi":"2395345","location":{"lat":"44.9633","lon":"93.2683"},"abbreviation":"MN"}
{"index":{"_index":"test-data","_type":"cities","_id":"48","_parent":"OH"}}
{"rank":"48","city":"Cleveland","state":"Ohio","population2012":"390928","population2010":"396815","land_area":"77.697","density":"5107","ansi":"1085963","location":{"lat":"41.4781","lon":"81.6795"},"abbreviation":"OH"}
{"index":{"_index":"test-data","_type":"cities","_id":"49","_parent":"KS"}}
{"rank":"49","city":"Wichita","state":"Kansas","population2012":"385577","population2010":"382368","land_area":"159.295","density":"2400","ansi":"485662","location":{"lat":"37.6907","lon":"97.3427"},"abbreviation":"KS"}
{"index":{"_index":"test-data","_type":"cities","_id":"50","_parent":"TX"}}
{"rank":"50","city":"Arlington","state":"Texas","population2012":"375600","population2010":"365438","land_area":"95.882","density":"3811","ansi":"2409731","location":{"lat":"32.7007","lon":"97.1247"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"51","_parent":"LA"}}
{"rank":"51","city":"New Orleans","state":"Louisiana","population2012":"369250","population2010":"343829","land_area":"169.423","density":"2029","ansi":"545142","location":{"lat":"30.0686","lon":"89.939"},"abbreviation":"LA"}
{"index":{"_index":"test-data","_type":"cities","_id":"52","_parent":"CA"}}
{"rank":"52","city":"Bakersfield","state":"California","population2012":"358597","population2010":"347483","land_area":"142.164","density":"2444","ansi":"2409774","location":{"lat":"35.3212","lon":"119.0183"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"53","_parent":"FL"}}
{"rank":"53","city":"Tampa","state":"Florida","population2012":"347645","population2010":"335709","land_area":"113.409","density":"2960","ansi":"2405568","location":{"lat":"27.9701","lon":"82.4797"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"54","_parent":"HI"}}
{"rank":"54","city":"Honolulu","state":"Hawaii","population2012":"345610","population2010":"337256","land_area":"60.521","density":"5573","ansi":"2630783","location":{"lat":"21.3259","lon":"157.8453"},"abbreviation":"HI"}
{"index":{"_index":"test-data","_type":"cities","_id":"55","_parent":"CA"}}
{"rank":"55","city":"Anaheim","state":"California","population2012":"343248","population2010":"336265","land_area":"49.835","density":"6748","ansi":"2409704","location":{"lat":"33.8555","lon":"117.7601"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"56","_parent":"CO"}}
{"rank":"56","city":"Aurora","state":"Colorado","population2012":"339030","population2010":"325078","land_area":"154.100","density":"2110","ansi":"2409731","location":{"lat":"32.7007","lon":"97.1247"},"abbreviation":"CO"}
{"index":{"_index":"test-data","_type":"cities","_id":"57","_parent":"CA"}}
{"rank":"57","city":"Santa Ana","state":"California","population2012":"330920","population2010":"324528","land_area":"27.270","density":"11901","ansi":"2411814","location":{"lat":"33.7365","lon":"117.8826"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"58","_parent":"MO"}}
{"rank":"58","city":"St. Louis","state":"Missouri","population2012":"318172","population2010":"319294","land_area":"61.909","density":"5157","ansi":"767557","location":{"lat":"38.6357","lon":"90.2446"},"abbreviation":"MO"}
{"index":{"_index":"test-data","_type":"cities","_id":"59","_parent":"CA"}}
{"rank":"59","city":"Riverside","state":"California","population2012":"313673","population2010":"303871","land_area":"81.140","density":"3745","ansi":"2410965","location":{"lat":"33.9381","lon":"117.3932"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"60","_parent":"TX"}}
{"rank":"60","city":"Corpus Christi","state":"Texas","population2012":"312195","population2010":"305215","land_area":"160.612","density":"1900","ansi":"2410234","location":{"lat":"27.7543","lon":"97.1734"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"61","_parent":"PA"}}
{"rank":"61","city":"Pittsburgh","state":"Pennsylvania","population2012":"306211","population2010":"305704","land_area":"55.367","density":"5521","ansi":"1214818","location":{"lat":"40.4398","lon":"79.9766"},"abbreviation":"PA"}
{"index":{"_index":"test-data","_type":"cities","_id":"62","_parent":"KY"}}
{"rank":"62","city":"Lexington","state":"Kentucky","population2012":"305489","population2010":"295803","land_area":"283.649","density":"1043","ansi":"2405089","location":{"lat":"38.0402","lon":"84.4584"},"abbreviation":"KY"}
{"index":{"_index":"test-data","_type":"cities","_id":"63","_parent":"AK"}}
{"rank":"63","city":"Anchorage","state":"Alaska","population2012":"298610","population2010":"291826","land_area":"1704.683","density":"171","ansi":"2419025","location":{"lat":"61.1775","lon":"149.2744"},"abbreviation":"AK"}
{"index":{"_index":"test-data","_type":"cities","_id":"64","_parent":"CA"}}
{"rank":"64","city":"Stockton","state":"California","population2012":"297984","population2010":"291707","land_area":"61.670","density":"4730","ansi":"2411987","location":{"lat":"37.9763","lon":"121.3133"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"65","_parent":"OH"}}
{"rank":"65","city":"Cincinnati","state":"Ohio","population2012":"296550","population2010":"296943","land_area":"77.942","density":"3810","ansi":"1086201","location":{"lat":"39.1399","lon":"84.5064"},"abbreviation":"OH"}
{"index":{"_index":"test-data","_type":"cities","_id":"66","_parent":"MN"}}
{"rank":"66","city":"Saint Paul","state":"Minnesota","population2012":"290770","population2010":"285068","land_area":"51.979","density":"5484","ansi":"2396511","location":{"lat":"44.9489","lon":"93.1039"},"abbreviation":"MN"}
{"index":{"_index":"test-data","_type":"cities","_id":"67","_parent":"OH"}}
{"rank":"67","city":"Toledo","state":"Ohio","population2012":"284012","population2010":"287208","land_area":"80.692","density":"3559","ansi":"1086537","location":{"lat":"41.6641","lon":"83.5819"},"abbreviation":"OH"}
{"index":{"_index":"test-data","_type":"cities","_id":"68","_parent":"NJ"}}
{"rank":"68","city":"Newark","state":"New Jersey","population2012":"277727","population2010":"277140","land_area":"24.187","density":"11458","ansi":"885317","location":{"lat":"40.7242","lon":"74.1726"},"abbreviation":"NJ"}
{"index":{"_index":"test-data","_type":"cities","_id":"69","_parent":"NC"}}
{"rank":"69","city":"Greensboro","state":"North Carolina","population2012":"277080","population2010":"269666","land_area":"126.515","density":"2131","ansi":"2403745","location":{"lat":"36.0965","lon":"79.8271"},"abbreviation":"NC"}
{"index":{"_index":"test-data","_type":"cities","_id":"70","_parent":"TX"}}
{"rank":"70","city":"Plano","state":"Texas","population2012":"272068","population2010":"259841","land_area":"71.581","density":"3630","ansi":"2411437","location":{"lat":"33.0508","lon":"96.7479"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"71","_parent":"NV"}}
{"rank":"71","city":"Henderson","state":"Nevada","population2012":"265679","population2010":"257729","land_area":"107.732","density":"2392","ansi":"2410741","location":{"lat":"36.0122","lon":"115.0375"},"abbreviation":"NV"}
{"index":{"_index":"test-data","_type":"cities","_id":"72","_parent":"NE"}}
{"rank":"72","city":"Lincoln","state":"Nebraska","population2012":"265404","population2010":"258379","land_area":"89.114","density":"2899","ansi":"2395713","location":{"lat":"40.809","lon":"96.6804"},"abbreviation":"NE"}
{"index":{"_index":"test-data","_type":"cities","_id":"73","_parent":"NY"}}
{"rank":"73","city":"Buffalo","state":"New York","population2012":"259384","population2010":"261310","land_area":"40.384","density":"6471","ansi":"978764","location":{"lat":"42.8925","lon":"78.8597"},"abbreviation":"NY"}
{"index":{"_index":"test-data","_type":"cities","_id":"74","_parent":"IN"}}
{"rank":"74","city":"Fort Wayne","state":"Indiana","population2012":"254555","population2010":"253691","land_area":"110.618","density":"2293","ansi":"2394798","location":{"lat":"41.0882","lon":"85.1439"},"abbreviation":"IN"}
{"index":{"_index":"test-data","_type":"cities","_id":"75","_parent":"NJ"}}
{"rank":"75","city":"Jersey City","state":"New Jersey","population2012":"254441","population2010":"247597","land_area":"14.794","density":"16737","ansi":"885264","location":{"lat":"40.7114","lon":"74.0648"},"abbreviation":"NJ"}
{"index":{"_index":"test-data","_type":"cities","_id":"76","_parent":"CA"}}
{"rank":"76","city":"Chula Vista","state":"California","population2012":"252422","population2010":"243916","land_area":"49.631","density":"4915","ansi":"2409461","location":{"lat":"32.6277","lon":"117.0152"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"77","_parent":"FL"}}
{"rank":"77","city":"Orlando","state":"Florida","population2012":"249562","population2010":"238300","land_area":"102.395","density":"2327","ansi":"2404443","location":{"lat":"28.4159","lon":"81.2988"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"78","_parent":"FL"}}
{"rank":"78","city":"St. Petersburg","state":"Florida","population2012":"246541","population2010":"244769","land_area":"61.742","density":"3964","ansi":"2405401","location":{"lat":"27.762","lon":"82.6441"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"79","_parent":"VA"}}
{"rank":"79","city":"Norfolk","state":"Virginia","population2012":"245782","population2010":"242803","land_area":"54.120","density":"4486","ansi":"1498557","location":{"lat":"36.923","lon":"76.2446"},"abbreviation":"VA"}
{"index":{"_index":"test-data","_type":"cities","_id":"80","_parent":"AZ"}}
{"rank":"80","city":"Chandler","state":"Arizona","population2012":"245628","population2010":"236123","land_area":"64.413","density":"3666","ansi":"2409433","location":{"lat":"33.2829","lon":"111.8549"},"abbreviation":"AZ"}
{"index":{"_index":"test-data","_type":"cities","_id":"81","_parent":"TX"}}
{"rank":"81","city":"Laredo","state":"Texas","population2012":"244731","population2010":"236091","land_area":"88.908","density":"2655","ansi":"2411626","location":{"lat":"27.5477","lon":"99.4869"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"82","_parent":"WI"}}
{"rank":"82","city":"Madison","state":"Wisconsin","population2012":"240323","population2010":"233209","land_area":"76.789","density":"3037","ansi":"1583625","location":{"lat":"43.0878","lon":"89.4301"},"abbreviation":"WI"}
{"index":{"_index":"test-data","_type":"cities","_id":"83","_parent":"NC"}}
{"rank":"83","city":"Durham","state":"North Carolina","population2012":"239358","population2010":"228330","land_area":"107.370","density":"2127","ansi":"2403521","location":{"lat":"35.981","lon":"78.9056"},"abbreviation":"NC"}
{"index":{"_index":"test-data","_type":"cities","_id":"84","_parent":"TX"}}
{"rank":"84","city":"Lubbock","state":"Texas","population2012":"236065","population2010":"229573","land_area":"122.410","density":"1875","ansi":"2410892","location":{"lat":"33.5665","lon":"101.8867"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"85","_parent":"NC"}}
{"rank":"85","city":"Winston-Salem","state":"North Carolina","population2012":"234349","population2010":"229617","land_area":"132.449","density":"1734","ansi":"2405771","location":{"lat":"36.1033","lon":"80.2606"},"abbreviation":"NC"}
{"index":{"_index":"test-data","_type":"cities","_id":"86","_parent":"TX"}}
{"rank":"86","city":"Garland","state":"Texas","population2012":"233564","population2010":"226876","land_area":"57.085","density":"3974","ansi":"2410572","location":{"lat":"32.9098","lon":"96.6304"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"87","_parent":"AZ"}}
{"rank":"87","city":"Glendale","state":"Arizona","population2012":"232143","population2010":"226721","land_area":"59.976","density":"3780","ansi":"2410596","location":{"lat":"33.5331","lon":"112.1899"},"abbreviation":"AZ"}
{"index":{"_index":"test-data","_type":"cities","_id":"88","_parent":"FL"}}
{"rank":"88","city":"Hialeah","state":"Florida","population2012":"231941","population2010":"224669","land_area":"21.450","density":"10474","ansi":"2404689","location":{"lat":"25.8699","lon":"80.3029"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"89","_parent":"NV"}}
{"rank":"89","city":"Reno","state":"Nevada","population2012":"231027","population2010":"225221","land_area":"103.009","density":"2186","ansi":"2410923","location":{"lat":"39.4745","lon":"119.7765"},"abbreviation":"NV"}
{"index":{"_index":"test-data","_type":"cities","_id":"90","_parent":"LA"}}
{"rank":"90","city":"Baton Rouge","state":"Louisiana","population2012":"230058","population2010":"229493","land_area":"76.947","density":"2982","ansi":"2403821","location":{"lat":"30.4485","lon":"91.1259"},"abbreviation":"LA"}
{"index":{"_index":"test-data","_type":"cities","_id":"91","_parent":"CA"}}
{"rank":"91","city":"Irvine","state":"California","population2012":"229985","population2010":"212375","land_area":"66.106","density":"3213","ansi":"2410116","location":{"lat":"33.6784","lon":"117.7713"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"92","_parent":"VA"}}
{"rank":"92","city":"Chesapeake","state":"Virginia","population2012":"228417","population2010":"222209","land_area":"340.800","density":"652","ansi":"1498558","location":{"lat":"36.6794","lon":"76.3018"},"abbreviation":"VA"}
{"index":{"_index":"test-data","_type":"cities","_id":"93","_parent":"TX"}}
{"rank":"93","city":"Irving","state":"Texas","population2012":"225427","population2010":"216290","land_area":"67.017","density":"3227","ansi":"2410117","location":{"lat":"32.8577","lon":"96.97"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"94","_parent":"AZ"}}
{"rank":"94","city":"Scottsdale","state":"Arizona","population2012":"223514","population2010":"217385","land_area":"183.920","density":"1182","ansi":"2411845","location":{"lat":"33.6687","lon":"111.8237"},"abbreviation":"AZ"}
{"index":{"_index":"test-data","_type":"cities","_id":"95","_parent":"NV"}}
{"rank":"95","city":"North Las Vegas","state":"Nevada","population2012":"223491","population2010":"216961","land_area":"101.345","density":"2141","ansi":"2411273","location":{"lat":"36.283","lon":"115.0893"},"abbreviation":"NV"}
{"index":{"_index":"test-data","_type":"cities","_id":"96","_parent":"CA"}}
{"rank":"96","city":"Fremont","state":"California","population2012":"221986","population2010":"214089","land_area":"77.459","density":"2764","ansi":"2410545","location":{"lat":"37.4944","lon":"121.9411"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"97","_parent":"AZ"}}
{"rank":"97","city":"Gilbert","state":"Arizona","population2012":"221140","population2010":"208453","land_area":"67.963","density":"3067","ansi":"2412682","location":{"lat":"33.3102","lon":"111.7422"},"abbreviation":"AZ"}
{"index":{"_index":"test-data","_type":"cities","_id":"98","_parent":"CA"}}
{"rank":"98","city":"San Bernardino","state":"California","population2012":"213295","population2010":"209924","land_area":"59.201","density":"3546","ansi":"2411777","location":{"lat":"34.1393","lon":"117.2953"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"99","_parent":"ID"}}
{"rank":"99","city":"Boise","state":"Idaho","population2012":"212303","population2010":"205671","land_area":"79.364","density":"2592","ansi":"2409876","location":{"lat":"43.5985","lon":"116.2311"},"abbreviation":"ID"}
{"index":{"_index":"test-data","_type":"cities","_id":"100","_parent":"AL"}}
{"rank":"100","city":"Birmingham","state":"Alabama","population2012":"212038","population2010":"212237","land_area":"146.067","density":"1453","ansi":"2403868","location":{"lat":"33.5274","lon":"86.799"},"abbreviation":"AL"}
{"index":{"_index":"test-data","_type":"cities","_id":"101","_parent":"NY"}}
{"rank":"101","city":"Rochester","state":"New York","population2012":"210532","population2010":"210565","land_area":"35.781","density":"5885","ansi":"979426","location":{"lat":"43.1699","lon":"77.6169"},"abbreviation":"NY"}
{"index":{"_index":"test-data","_type":"cities","_id":"102","_parent":"VA"}}
{"rank":"102","city":"Richmond","state":"Virginia","population2012":"210309","population2010":"204214","land_area":"59.805","density":"3415","ansi":"1789073","location":{"lat":"37.5314","lon":"77.476"},"abbreviation":"VA"}
{"index":{"_index":"test-data","_type":"cities","_id":"103","_parent":"WA"}}
{"rank":"103","city":"Spokane","state":"Washington","population2012":"209525","population2010":"208916","land_area":"59.247","density":"3526","ansi":"2411956","location":{"lat":"47.6736","lon":"117.4166"},"abbreviation":"WA"}
{"index":{"_index":"test-data","_type":"cities","_id":"104","_parent":"IA"}}
{"rank":"104","city":"Des Moines","state":"Iowa","population2012":"206688","population2010":"203433","land_area":"80.869","density":"2516","ansi":"2394522","location":{"lat":"41.5739","lon":"93.6167"},"abbreviation":"IA"}
{"index":{"_index":"test-data","_type":"cities","_id":"105","_parent":"AL"}}
{"rank":"105","city":"Montgomery","state":"Alabama","population2012":"205293","population2010":"205764","land_area":"159.565","density":"1290","ansi":"2404289","location":{"lat":"32.3463","lon":"86.2686"},"abbreviation":"AL"}
{"index":{"_index":"test-data","_type":"cities","_id":"106","_parent":"CA"}}
{"rank":"106","city":"Modesto","state":"California","population2012":"203547","population2010":"201165","land_area":"36.867","density":"5456","ansi":"2411130","location":{"lat":"37.6609","lon":"120.9891"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"107","_parent":"NC"}}
{"rank":"107","city":"Fayetteville","state":"North Carolina","population2012":"202103","population2010":"200564","land_area":"145.845","density":"1375","ansi":"2403604","location":{"lat":"35.0851","lon":"78.9803"},"abbreviation":"NC"}
{"index":{"_index":"test-data","_type":"cities","_id":"108","_parent":"WA"}}
{"rank":"108","city":"Tacoma","state":"Washington","population2012":"202010","population2010":"198397","land_area":"49.721","density":"3990","ansi":"2412025","location":{"lat":"47.2522","lon":"122.4598"},"abbreviation":"WA"}
{"index":{"_index":"test-data","_type":"cities","_id":"109","_parent":"LA"}}
{"rank":"109","city":"Shreveport","state":"Louisiana","population2012":"201867","population2010":"199311","land_area":"105.375","density":"1891","ansi":"2405463","location":{"lat":"32.467","lon":"93.7927"},"abbreviation":"LA"}
{"index":{"_index":"test-data","_type":"cities","_id":"110","_parent":"CA"}}
{"rank":"110","city":"Fontana","state":"California","population2012":"201812","population2010":"196069","land_area":"42.432","density":"4621","ansi":"2410517","location":{"lat":"34.1088","lon":"117.4627"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"111","_parent":"CA"}}
{"rank":"111","city":"Oxnard","state":"California","population2012":"201555","population2010":"197899","land_area":"26.894","density":"7358","ansi":"2411347","location":{"lat":"34.2023","lon":"119.2046"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"112","_parent":"IL"}}
{"rank":"112","city":"Aurora","state":"Illinois","population2012":"199932","population2010":"197899","land_area":"44.936","density":"4404","ansi":"2394031","location":{"lat":"41.7635","lon":"88.2901"},"abbreviation":"IL"}
{"index":{"_index":"test-data","_type":"cities","_id":"113","_parent":"CA"}}
{"rank":"113","city":"Moreno Valley","state":"California","population2012":"199552","population2010":"193365","land_area":"51.275","density":"3771","ansi":"2411159","location":{"lat":"33.9233","lon":"117.2057"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"114","_parent":"OH"}}
{"rank":"114","city":"Akron","state":"Ohio","population2012":"198549","population2010":"199110","land_area":"62.033","density":"3210","ansi":"1086993","location":{"lat":"41.0805","lon":"81.5214"},"abbreviation":"OH"}
{"index":{"_index":"test-data","_type":"cities","_id":"115","_parent":"NY"}}
{"rank":"115","city":"Yonkers","state":"New York","population2012":"198449","population2010":"195976","land_area":"18.012","density":"10880","ansi":"979660","location":{"lat":"40.9459","lon":"73.8674"},"abbreviation":"NY"}
{"index":{"_index":"test-data","_type":"cities","_id":"116","_parent":"GA"}}
{"rank":"116","city":"Columbus","state":"Georgia","population2012":"198413","population2010":"189885","land_area":"216.385","density":"878","ansi":"2404111","location":{"lat":"32.5102","lon":"84.8749"},"abbreviation":"GA"}
{"index":{"_index":"test-data","_type":"cities","_id":"117","_parent":"GA"}}
{"rank":"117","city":"Augusta","state":"Georgia","population2012":"197872","population2010":"195844","land_area":"302.474","density":"647","ansi":"2405078","location":{"lat":"33.3655","lon":"82.0734"},"abbreviation":"GA"}
{"index":{"_index":"test-data","_type":"cities","_id":"118","_parent":"AR"}}
{"rank":"118","city":"Little Rock","state":"Arkansas","population2012":"196537","population2010":"193524","land_area":"119.200","density":"1624","ansi":"2404939","location":{"lat":"34.7254","lon":"92.3586"},"abbreviation":"AR"}
{"index":{"_index":"test-data","_type":"cities","_id":"119","_parent":"TX"}}
{"rank":"119","city":"Amarillo","state":"Texas","population2012":"195250","population2010":"190695","land_area":"99.476","density":"1917","ansi":"2409694","location":{"lat":"35.1978","lon":"101.8287"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"120","_parent":"AL"}}
{"rank":"120","city":"Mobile","state":"Alabama","population2012":"194822","population2010":"195111","land_area":"139.109","density":"1403","ansi":"2404278","location":{"lat":"30.6684","lon":"88.1002"},"abbreviation":"AL"}
{"index":{"_index":"test-data","_type":"cities","_id":"121","_parent":"CA"}}
{"rank":"121","city":"Huntington Beach","state":"California","population2012":"194708","population2010":"189992","land_area":"26.748","density":"7103","ansi":"2410811","location":{"lat":"33.6906","lon":"118.0093"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"122","_parent":"CA"}}
{"rank":"122","city":"Glendale","state":"California","population2012":"194478","population2010":"191719","land_area":"30.453","density":"6295","ansi":"2410597","location":{"lat":"34.1814","lon":"118.2458"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"123","_parent":"MI"}}
{"rank":"123","city":"Grand Rapids","state":"Michigan","population2012":"190411","population2010":"188040","land_area":"44.395","density":"4236","ansi":"1626373","location":{"lat":"42.9612","lon":"85.6556"},"abbreviation":"MI"}
{"index":{"_index":"test-data","_type":"cities","_id":"124","_parent":"UT"}}
{"rank":"124","city":"Salt Lake City","state":"Utah","population2012":"189314","population2010":"186440","land_area":"111.110","density":"1678","ansi":"2411771","location":{"lat":"40.7785","lon":"111.9314"},"abbreviation":"UT"}
{"index":{"_index":"test-data","_type":"cities","_id":"125","_parent":"FL"}}
{"rank":"125","city":"Tallahassee","state":"Florida","population2012":"186971","population2010":"181376","land_area":"100.247","density":"1809","ansi":"2405563","location":{"lat":"30.4551","lon":"84.2534"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"126","_parent":"AL"}}
{"rank":"126","city":"Huntsville","state":"Alabama","population2012":"183739","population2010":"180105","land_area":"209.054","density":"862","ansi":"2404746","location":{"lat":"34.7843","lon":"86.539"},"abbreviation":"AL"}
{"index":{"_index":"test-data","_type":"cities","_id":"127","_parent":"MA"}}
{"rank":"127","city":"Worcester","state":"Massachusetts","population2012":"182669","population2010":"181045","land_area":"37.371","density":"4845","ansi":"619493","location":{"lat":"42.2695","lon":"71.8078"},"abbreviation":"MA"}
{"index":{"_index":"test-data","_type":"cities","_id":"128","_parent":"TN"}}
{"rank":"128","city":"Knoxville","state":"Tennessee","population2012":"182200","population2010":"178874","land_area":"98.521","density":"1816","ansi":"2404842","location":{"lat":"35.9709","lon":"83.9465"},"abbreviation":"TN"}
{"index":{"_index":"test-data","_type":"cities","_id":"129","_parent":"TX"}}
{"rank":"129","city":"Grand Prairie","state":"Texas","population2012":"181824","population2010":"175396","land_area":"72.105","density":"2433","ansi":"2410632","location":{"lat":"32.6842","lon":"97.021"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"130","_parent":"VA"}}
{"rank":"130","city":"Newport News","state":"Virginia","population2012":"180726","population2010":"180719","land_area":"68.714","density":"2630","ansi":"1498555","location":{"lat":"37.076","lon":"76.5217"},"abbreviation":"VA"}
{"index":{"_index":"test-data","_type":"cities","_id":"131","_parent":"TX"}}
{"rank":"131","city":"Brownsville","state":"Texas","population2012":"180097","population2010":"175023","land_area":"132.330","density":"1323","ansi":"2409924","location":{"lat":"26.0183","lon":"97.4538"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"132","_parent":"CA"}}
{"rank":"132","city":"Santa Clarita","state":"California","population2012":"179013","population2010":"176320","land_area":"52.716","density":"3345","ansi":"2411819","location":{"lat":"34.4049","lon":"118.5047"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"133","_parent":"KS"}}
{"rank":"133","city":"Overland Park","state":"Kansas","population2012":"178919","population2010":"173372","land_area":"74.841","density":"2317","ansi":"485639","location":{"lat":"38.889","lon":"94.6906"},"abbreviation":"KS"}
{"index":{"_index":"test-data","_type":"cities","_id":"134","_parent":"RI"}}
{"rank":"134","city":"Providence","state":"Rhode Island","population2012":"178432","population2010":"178042","land_area":"18.400","density":"9676","ansi":"1220076","location":{"lat":"41.8231","lon":"71.4188"},"abbreviation":"RI"}
{"index":{"_index":"test-data","_type":"cities","_id":"135","_parent":"MS"}}
{"rank":"135","city":"Jackson","state":"Mississippi","population2012":"175437","population2010":"173514","land_area":"111.046","density":"1563","ansi":"2404779","location":{"lat":"32.3158","lon":"90.2128"},"abbreviation":"MS"}
{"index":{"_index":"test-data","_type":"cities","_id":"136","_parent":"CA"}}
{"rank":"136","city":"Garden Grove","state":"California","population2012":"174389","population2010":"170883","land_area":"17.941","density":"9525","ansi":"2410568","location":{"lat":"33.7788","lon":"117.9605"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"137","_parent":"CA"}}
{"rank":"137","city":"Oceanside","state":"California","population2012":"171293","population2010":"167086","land_area":"41.235","density":"4052","ansi":"2411301","location":{"lat":"33.2246","lon":"117.3062"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"138","_parent":"TN"}}
{"rank":"138","city":"Chattanooga","state":"Tennessee","population2012":"171279","population2010":"167674","land_area":"137.152","density":"1223","ansi":"2404035","location":{"lat":"35.0665","lon":"85.2471"},"abbreviation":"TN"}
{"index":{"_index":"test-data","_type":"cities","_id":"139","_parent":"FL"}}
{"rank":"139","city":"Fort Lauderdale","state":"Florida","population2012":"170747","population2010":"165521","land_area":"34.765","density":"4761","ansi":"2403640","location":{"lat":"26.1413","lon":"80.1439"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"140","_parent":"CA"}}
{"rank":"140","city":"Rancho Cucamonga","state":"California","population2012":"170746","population2010":"165269","land_area":"39.851","density":"4147","ansi":"2411514","location":{"lat":"34.1233","lon":"117.5642"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"141","_parent":"CA"}}
{"rank":"141","city":"Santa Rosa","state":"California","population2012":"170685","population2010":"167815","land_area":"41.294","density":"4064","ansi":"2411827","location":{"lat":"38.4468","lon":"122.7061"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"142","_parent":"FL"}}
{"rank":"142","city":"Port St. Lucie","state":"Florida","population2012":"168716","population2010":"164603","land_area":"113.953","density":"1444","ansi":"2404558","location":{"lat":"27.281","lon":"80.3838"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"143","_parent":"CA"}}
{"rank":"143","city":"Ontario","state":"California","population2012":"167211","population2010":"163924","land_area":"49.941","density":"3282","ansi":"2411323","location":{"lat":"34.0395","lon":"117.6088"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"144","_parent":"AZ"}}
{"rank":"144","city":"Tempe","state":"Arizona","population2012":"166842","population2010":"161719","land_area":"39.929","density":"4050","ansi":"2412045","location":{"lat":"33.3884","lon":"111.9318"},"abbreviation":"AZ"}
{"index":{"_index":"test-data","_type":"cities","_id":"145","_parent":"WA"}}
{"rank":"145","city":"Vancouver","state":"Washington","population2012":"165489","population2010":"161791","land_area":"46.456","density":"3483","ansi":"2412146","location":{"lat":"45.6372","lon":"122.5965"},"abbreviation":"WA"}
{"index":{"_index":"test-data","_type":"cities","_id":"146","_parent":"MO"}}
{"rank":"146","city":"Springfield","state":"Missouri","population2012":"162191","population2010":"159498","land_area":"81.720","density":"1952","ansi":"2395942","location":{"lat":"37.1942","lon":"93.2913"},"abbreviation":"MO"}
{"index":{"_index":"test-data","_type":"cities","_id":"147","_parent":"FL"}}
{"rank":"147","city":"Cape Coral","state":"Florida","population2012":"161248","population2010":"154305","land_area":"105.673","density":"1460","ansi":"2403990","location":{"lat":"26.6431","lon":"81.9973"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"148","_parent":"FL"}}
{"rank":"148","city":"Pembroke Pines","state":"Florida","population2012":"160306","population2010":"154750","land_area":"33.124","density":"4672","ansi":"2404502","location":{"lat":"26.0212","lon":"80.3404"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"149","_parent":"SD"}}
{"rank":"149","city":"Sioux Falls","state":"South Dakota","population2012":"159908","population2010":"153888","land_area":"72.964","density":"2109","ansi":"1267566","location":{"lat":"43.5383","lon":"96.732"},"abbreviation":"SD"}
{"index":{"_index":"test-data","_type":"cities","_id":"150","_parent":"AZ"}}
{"rank":"150","city":"Peoria","state":"Arizona","population2012":"159789","population2010":"154065","land_area":"174.404","density":"883","ansi":"2411401","location":{"lat":"33.7877","lon":"112.3111"},"abbreviation":"AZ"}
{"index":{"_index":"test-data","_type":"cities","_id":"151","_parent":"CA"}}
{"rank":"151","city":"Lancaster","state":"California","population2012":"159055","population2010":"156633","land_area":"94.276","density":"1661","ansi":"2411620","location":{"lat":"34.6936","lon":"118.1753"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"152","_parent":"CA"}}
{"rank":"152","city":"Elk Grove","state":"California","population2012":"159038","population2010":"153015","land_area":"42.190","density":"3627","ansi":"2410425","location":{"lat":"38.4144","lon":"121.3849"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"153","_parent":"CA"}}
{"rank":"153","city":"Corona","state":"California","population2012":"158391","population2010":"152374","land_area":"38.825","density":"3925","ansi":"2410232","location":{"lat":"33.8624","lon":"117.5639"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"154","_parent":"OR"}}
{"rank":"154","city":"Eugene","state":"Oregon","population2012":"157986","population2010":"156185","land_area":"43.723","density":"3572","ansi":"2410460","location":{"lat":"44.0567","lon":"123.1162"},"abbreviation":"OR"}
{"index":{"_index":"test-data","_type":"cities","_id":"155","_parent":"OR"}}
{"rank":"155","city":"Salem","state":"Oregon","population2012":"157429","population2010":"154637","land_area":"47.896","density":"3229","ansi":"2411764","location":{"lat":"44.9237","lon":"123.0231"},"abbreviation":"OR"}
{"index":{"_index":"test-data","_type":"cities","_id":"156","_parent":"CA"}}
{"rank":"156","city":"Palmdale","state":"California","population2012":"155650","population2010":"152750","land_area":"105.961","density":"1442","ansi":"2411359","location":{"lat":"34.5913","lon":"118.109"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"157","_parent":"CA"}}
{"rank":"157","city":"Salinas","state":"California","population2012":"154484","population2010":"150441","land_area":"23.179","density":"6490","ansi":"2411768","location":{"lat":"36.6902","lon":"121.6337"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"158","_parent":"MA"}}
{"rank":"158","city":"Springfield","state":"Massachusetts","population2012":"153552","population2010":"153060","land_area":"31.865","density":"4803","ansi":"619388","location":{"lat":"42.1155","lon":"72.54"},"abbreviation":"MA"}
{"index":{"_index":"test-data","_type":"cities","_id":"159","_parent":"TX"}}
{"rank":"159","city":"Pasadena","state":"Texas","population2012":"152272","population2010":"149043","land_area":"42.762","density":"3485","ansi":"2411380","location":{"lat":"29.6583","lon":"95.1505"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"160","_parent":"IL"}}
{"rank":"160","city":"Rockford","state":"Illinois","population2012":"150843","population2010":"152871","land_area":"61.081","density":"2503","ansi":"2396405","location":{"lat":"42.2634","lon":"89.0628"},"abbreviation":"IL"}
{"index":{"_index":"test-data","_type":"cities","_id":"161","_parent":"CA"}}
{"rank":"161","city":"Pomona","state":"California","population2012":"150812","population2010":"149058","land_area":"22.952","density":"6494","ansi":"2411454","location":{"lat":"34.0586","lon":"117.7613"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"162","_parent":"CA"}}
{"rank":"162","city":"Hayward","state":"California","population2012":"149392","population2010":"144186","land_area":"45.323","density":"3181","ansi":"2410724","location":{"lat":"37.6281","lon":"122.1063"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"163","_parent":"CO"}}
{"rank":"163","city":"Fort Collins","state":"Colorado","population2012":"148612","population2010":"143986","land_area":"54.277","density":"2653","ansi":"2410526","location":{"lat":"40.5482","lon":"105.0648"},"abbreviation":"CO"}
{"index":{"_index":"test-data","_type":"cities","_id":"164","_parent":"IL"}}
{"rank":"164","city":"Joliet","state":"Illinois","population2012":"148268","population2010":"147433","land_area":"62.114","density":"2374","ansi":"2395477","location":{"lat":"41.5181","lon":"88.1584"},"abbreviation":"IL"}
{"index":{"_index":"test-data","_type":"cities","_id":"165","_parent":"CA"}}
{"rank":"165","city":"Escondido","state":"California","population2012":"147575","population2010":"143911","land_area":"36.813","density":"3909","ansi":"2410455","location":{"lat":"33.1336","lon":"117.0732"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"166","_parent":"KS"}}
{"rank":"166","city":"Kansas City","state":"Kansas","population2012":"147268","population2010":"145786","land_area":"124.810","density":"1168","ansi":"485601","location":{"lat":"39.1225","lon":"94.7418"},"abbreviation":"KS"}
{"index":{"_index":"test-data","_type":"cities","_id":"167","_parent":"CA"}}
{"rank":"167","city":"Torrance","state":"California","population2012":"147027","population2010":"145438","land_area":"20.478","density":"7102","ansi":"2412087","location":{"lat":"33.835","lon":"118.3414"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"168","_parent":"CT"}}
{"rank":"168","city":"Bridgeport","state":"Connecticut","population2012":"146425","population2010":"144229","land_area":"15.974","density":"9029","ansi":"2378269","location":{"lat":"41.1874","lon":"73.1957"},"abbreviation":"CT"}
{"index":{"_index":"test-data","_type":"cities","_id":"169","_parent":"VA"}}
{"rank":"169","city":"Alexandria","state":"Virginia","population2012":"146294","population2010":"139966","land_area":"15.027","density":"9314","ansi":"1498415","location":{"lat":"38.8183","lon":"77.082"},"abbreviation":"VA"}
{"index":{"_index":"test-data","_type":"cities","_id":"170","_parent":"CA"}}
{"rank":"170","city":"Sunnyvale","state":"California","population2012":"146197","population2010":"140081","land_area":"21.987","density":"6371","ansi":"2412009","location":{"lat":"37.3858","lon":"122.0263"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"171","_parent":"NC"}}
{"rank":"171","city":"Cary","state":"North Carolina","population2012":"145693","population2010":"135234","land_area":"54.345","density":"2488","ansi":"2406229","location":{"lat":"35.7821","lon":"78.8141"},"abbreviation":"NC"}
{"index":{"_index":"test-data","_type":"cities","_id":"172","_parent":"CO"}}
{"rank":"172","city":"Lakewood","state":"Colorado","population2012":"145516","population2010":"142980","land_area":"42.880","density":"3334","ansi":"2411614","location":{"lat":"39.6989","lon":"105.1176"},"abbreviation":"CO"}
{"index":{"_index":"test-data","_type":"cities","_id":"173","_parent":"FL"}}
{"rank":"173","city":"Hollywood","state":"Florida","population2012":"145236","population2010":"140768","land_area":"27.366","density":"5144","ansi":"2404719","location":{"lat":"26.0311","lon":"80.1646"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"174","_parent":"NJ"}}
{"rank":"174","city":"Paterson","state":"New Jersey","population2012":"145219","population2010":"146199","land_area":"8.428","density":"17346","ansi":"885343","location":{"lat":"40.9147","lon":"74.1628"},"abbreviation":"NJ"}
{"index":{"_index":"test-data","_type":"cities","_id":"175","_parent":"NY"}}
{"rank":"175","city":"Syracuse","state":"New York","population2012":"144170","population2010":"145170","land_area":"25.043","density":"5797","ansi":"979539","location":{"lat":"43.041","lon":"76.1436"},"abbreviation":"NY"}
{"index":{"_index":"test-data","_type":"cities","_id":"176","_parent":"IL"}}
{"rank":"176","city":"Naperville","state":"Illinois","population2012":"143684","population2010":"141853","land_area":"38.769","density":"3659","ansi":"2395147","location":{"lat":"41.7492","lon":"88.162"},"abbreviation":"IL"}
{"index":{"_index":"test-data","_type":"cities","_id":"177","_parent":"TX"}}
{"rank":"177","city":"McKinney","state":"Texas","population2012":"143223","population2010":"131117","land_area":"62.209","density":"2108","ansi":"2411064","location":{"lat":"33.2012","lon":"96.668"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"178","_parent":"TX"}}
{"rank":"178","city":"Mesquite","state":"Texas","population2012":"143195","population2010":"139824","land_area":"46.021","density":"3038","ansi":"2411090","location":{"lat":"32.7639","lon":"96.5924"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"179","_parent":"TN"}}
{"rank":"179","city":"Clarksville","state":"Tennessee","population2012":"142519","population2010":"132929","land_area":"97.603","density":"1362","ansi":"2404061","location":{"lat":"36.5664","lon":"87.3452"},"abbreviation":"TN"}
{"index":{"_index":"test-data","_type":"cities","_id":"180","_parent":"GA"}}
{"rank":"180","city":"Savannah","state":"Georgia","population2012":"142022","population2010":"136286","land_area":"103.151","density":"1321","ansi":"2405429","location":{"lat":"32.0025","lon":"81.1536"},"abbreviation":"GA"}
{"index":{"_index":"test-data","_type":"cities","_id":"181","_parent":"OH"}}
{"rank":"181","city":"Dayton","state":"Ohio","population2012":"141359","population2010":"141527","land_area":"55.652","density":"2543","ansi":"1086666","location":{"lat":"39.7774","lon":"84.1996"},"abbreviation":"OH"}
{"index":{"_index":"test-data","_type":"cities","_id":"182","_parent":"CA"}}
{"rank":"182","city":"Orange","state":"California","population2012":"139419","population2010":"136416","land_area":"24.797","density":"5501","ansi":"2411325","location":{"lat":"33.8048","lon":"117.8249"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"183","_parent":"CA"}}
{"rank":"183","city":"Fullerton","state":"California","population2012":"138574","population2010":"135161","land_area":"22.353","density":"6047","ansi":"2410556","location":{"lat":"33.8857","lon":"117.928"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"184","_parent":"CA"}}
{"rank":"184","city":"Pasadena","state":"California","population2012":"138547","population2010":"137122","land_area":"22.970","density":"5970","ansi":"2411379","location":{"lat":"34.1606","lon":"118.1396"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"185","_parent":"VA"}}
{"rank":"185","city":"Hampton","state":"Virginia","population2012":"136836","population2010":"137436","land_area":"51.413","density":"2673","ansi":"1498554","location":{"lat":"37.048","lon":"76.2971"},"abbreviation":"VA"}
{"index":{"_index":"test-data","_type":"cities","_id":"186","_parent":"TX"}}
{"rank":"186","city":"McAllen","state":"Texas","population2012":"134719","population2010":"129877","land_area":"48.344","density":"2687","ansi":"2411057","location":{"lat":"26.2185","lon":"98.2461"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"187","_parent":"TX"}}
{"rank":"187","city":"Killeen","state":"Texas","population2012":"134654","population2010":"127921","land_area":"53.580","density":"2387","ansi":"2411542","location":{"lat":"31.0777","lon":"97.732"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"188","_parent":"MI"}}
{"rank":"188","city":"Warren","state":"Michigan","population2012":"134141","population2010":"134056","land_area":"34.381","density":"3899","ansi":"1627213","location":{"lat":"42.4929","lon":"83.025"},"abbreviation":"MI"}
{"index":{"_index":"test-data","_type":"cities","_id":"189","_parent":"UT"}}
{"rank":"189","city":"West Valley City","state":"Utah","population2012":"132434","population2010":"129480","land_area":"35.556","density":"3642","ansi":"2412231","location":{"lat":"40.6885","lon":"112.0118"},"abbreviation":"UT"}
{"index":{"_index":"test-data","_type":"cities","_id":"190","_parent":"SC"}}
{"rank":"190","city":"Columbia","state":"South Carolina","population2012":"131686","population2010":"129272","land_area":"132.213","density":"978","ansi":"2404107","location":{"lat":"34.0298","lon":"80.8966"},"abbreviation":"SC"}
{"index":{"_index":"test-data","_type":"cities","_id":"191","_parent":"CT"}}
{"rank":"191","city":"New Haven","state":"Connecticut","population2012":"130741","population2010":"129779","land_area":"18.679","density":"6948","ansi":"2378285","location":{"lat":"41.3108","lon":"72.925"},"abbreviation":"CT"}
{"index":{"_index":"test-data","_type":"cities","_id":"192","_parent":"MI"}}
{"rank":"192","city":"Sterling Heights","state":"Michigan","population2012":"130410","population2010":"129699","land_area":"36.505","density":"3553","ansi":"1627126","location":{"lat":"42.5812","lon":"83.0303"},"abbreviation":"MI"}
{"index":{"_index":"test-data","_type":"cities","_id":"193","_parent":"KS"}}
{"rank":"193","city":"Olathe","state":"Kansas","population2012":"130045","population2010":"125872","land_area":"59.661","density":"2110","ansi":"485633","location":{"lat":"38.8843","lon":"94.8188"},"abbreviation":"KS"}
{"index":{"_index":"test-data","_type":"cities","_id":"194","_parent":"FL"}}
{"rank":"194","city":"Miramar","state":"Florida","population2012":"128729","population2010":"122041","land_area":"29.521","density":"4134","ansi":"2404275","location":{"lat":"25.977","lon":"80.3358"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"195","_parent":"CA"}}
{"rank":"195","city":"Thousand Oaks","state":"California","population2012":"128412","population2010":"126683","land_area":"55.031","density":"2302","ansi":"2412065","location":{"lat":"34.1933","lon":"118.8742"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"196","_parent":"TX"}}
{"rank":"196","city":"Frisco","state":"Texas","population2012":"128176","population2010":"116989","land_area":"61.804","density":"1893","ansi":"2410549","location":{"lat":"33.151","lon":"96.8193"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"197","_parent":"IA"}}
{"rank":"197","city":"Cedar Rapids","state":"Iowa","population2012":"128119","population2010":"126326","land_area":"70.799","density":"1784","ansi":"467567","location":{"lat":"41.967","lon":"91.6778"},"abbreviation":"IA"}
{"index":{"_index":"test-data","_type":"cities","_id":"198","_parent":"KS"}}
{"rank":"198","city":"Topeka","state":"Kansas","population2012":"127939","population2010":"127473","land_area":"60.168","density":"2119","ansi":"485655","location":{"lat":"39.0362","lon":"95.6948"},"abbreviation":"KS"}
{"index":{"_index":"test-data","_type":"cities","_id":"199","_parent":"CA"}}
{"rank":"199","city":"Visalia","state":"California","population2012":"127081","population2010":"124442","land_area":"36.246","density":"3433","ansi":"2412160","location":{"lat":"36.3272","lon":"119.3234"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"200","_parent":"TX"}}
{"rank":"200","city":"Waco","state":"Texas","population2012":"127018","population2010":"124805","land_area":"88.964","density":"1403","ansi":"2412162","location":{"lat":"31.5601","lon":"97.186"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"201","_parent":"NJ"}}
{"rank":"201","city":"Elizabeth","state":"New Jersey","population2012":"126458","population2010":"124969","land_area":"12.319","density":"10144","ansi":"885205","location":{"lat":"40.6663","lon":"74.1935"},"abbreviation":"NJ"}
{"index":{"_index":"test-data","_type":"cities","_id":"202","_parent":"WA"}}
{"rank":"202","city":"Bellevue","state":"Washington","population2012":"126439","population2010":"122363","land_area":"31.968","density":"3828","ansi":"2409821","location":{"lat":"47.5978","lon":"122.1565"},"abbreviation":"WA"}
{"index":{"_index":"test-data","_type":"cities","_id":"203","_parent":"FL"}}
{"rank":"203","city":"Gainesville","state":"Florida","population2012":"126047","population2010":"124354","land_area":"61.305","density":"2028","ansi":"2403676","location":{"lat":"29.6788","lon":"82.3459"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"204","_parent":"CA"}}
{"rank":"204","city":"Simi Valley","state":"California","population2012":"125793","population2010":"124237","land_area":"41.480","density":"2995","ansi":"2411904","location":{"lat":"34.2669","lon":"118.7485"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"205","_parent":"SC"}}
{"rank":"205","city":"Charleston","state":"South Carolina","population2012":"125583","population2010":"120083","land_area":"108.979","density":"1102","ansi":"2404030","location":{"lat":"32.8179","lon":"79.9589"},"abbreviation":"SC"}
{"index":{"_index":"test-data","_type":"cities","_id":"206","_parent":"TX"}}
{"rank":"206","city":"Carrollton","state":"Texas","population2012":"125409","population2010":"119097","land_area":"36.296","density":"3281","ansi":"2409992","location":{"lat":"32.9884","lon":"96.8998"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"207","_parent":"FL"}}
{"rank":"207","city":"Coral Springs","state":"Florida","population2012":"125287","population2010":"121096","land_area":"23.792","density":"5090","ansi":"2404127","location":{"lat":"26.2708","lon":"80.2593"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"208","_parent":"CT"}}
{"rank":"208","city":"Stamford","state":"Connecticut","population2012":"125109","population2010":"122643","land_area":"37.639","density":"3258","ansi":"2378291","location":{"lat":"41.0799","lon":"73.546"},"abbreviation":"CT"}
{"index":{"_index":"test-data","_type":"cities","_id":"209","_parent":"CT"}}
{"rank":"209","city":"Hartford","state":"Connecticut","population2012":"124893","population2010":"124775","land_area":"17.381","density":"7179","ansi":"2378277","location":{"lat":"41.766","lon":"72.6833"},"abbreviation":"CT"}
{"index":{"_index":"test-data","_type":"cities","_id":"210","_parent":"CA"}}
{"rank":"210","city":"Concord","state":"California","population2012":"124711","population2010":"122067","land_area":"30.546","density":"3996","ansi":"2410214","location":{"lat":"37.9722","lon":"122.0016"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"211","_parent":"CA"}}
{"rank":"211","city":"Roseville","state":"California","population2012":"124519","population2010":"118788","land_area":"36.222","density":"3279","ansi":"2411000","location":{"lat":"38.7657","lon":"121.3032"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"212","_parent":"CO"}}
{"rank":"212","city":"Thornton","state":"Colorado","population2012":"124140","population2010":"118772","land_area":"34.843","density":"3409","ansi":"2412064","location":{"lat":"39.918","lon":"104.9454"},"abbreviation":"CO"}
{"index":{"_index":"test-data","_type":"cities","_id":"213","_parent":"WA"}}
{"rank":"213","city":"Kent","state":"Washington","population2012":"122999","population2010":"92411","land_area":"28.625","density":"3228","ansi":"2410185","location":{"lat":"47.3853","lon":"122.2169"},"abbreviation":"WA"}
{"index":{"_index":"test-data","_type":"cities","_id":"214","_parent":"LA"}}
{"rank":"214","city":"Lafayette","state":"Louisiana","population2012":"122761","population2010":"120623","land_area":"49.231","density":"2450","ansi":"2404854","location":{"lat":"30.2116","lon":"92.0314"},"abbreviation":"LA"}
{"index":{"_index":"test-data","_type":"cities","_id":"215","_parent":"AZ"}}
{"rank":"215","city":"Surprise","state":"Arizona","population2012":"121287","population2010":"117517","land_area":"105.747","density":"1111","ansi":"2412016","location":{"lat":"33.6706","lon":"112.4527"},"abbreviation":"AZ"}
{"index":{"_index":"test-data","_type":"cities","_id":"216","_parent":"TX"}}
{"rank":"216","city":"Denton","state":"Texas","population2012":"121123","population2010":"113383","land_area":"87.952","density":"1289","ansi":"2410323","location":{"lat":"33.2151","lon":"97.1417"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"217","_parent":"CA"}}
{"rank":"217","city":"Victorville","state":"California","population2012":"120336","population2010":"115903","land_area":"73.178","density":"1584","ansi":"2412156","location":{"lat":"34.5277","lon":"117.3536"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"218","_parent":"IN"}}
{"rank":"218","city":"Evansville","state":"Indiana","population2012":"120235","population2010":"117429","land_area":"44.153","density":"2660","ansi":"2394710","location":{"lat":"37.9877","lon":"87.5347"},"abbreviation":"IN"}
{"index":{"_index":"test-data","_type":"cities","_id":"219","_parent":"TX"}}
{"rank":"219","city":"Midland","state":"Texas","population2012":"119385","population2010":"111147","land_area":"72.071","density":"1542","ansi":"2411096","location":{"lat":"32.0299","lon":"102.1097"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"220","_parent":"CA"}}
{"rank":"220","city":"Santa Clara","state":"California","population2012":"119311","population2010":"116468","land_area":"18.407","density":"6327","ansi":"2411816","location":{"lat":"37.3646","lon":"121.9679"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"221","_parent":"GA"}}
{"rank":"221","city":"Athens","state":"Georgia","population2012":"118999","population2010":"115452","land_area":"116.355","density":"992","ansi":"2407405","location":{"lat":"33.9496","lon":"83.3701"},"abbreviation":"GA"}
{"index":{"_index":"test-data","_type":"cities","_id":"222","_parent":"PA"}}
{"rank":"222","city":"Allentown","state":"Pennsylvania","population2012":"118974","population2010":"118032","land_area":"17.546","density":"6727","ansi":"1215372","location":{"lat":"40.594","lon":"75.4782"},"abbreviation":"PA"}
{"index":{"_index":"test-data","_type":"cities","_id":"223","_parent":"TX"}}
{"rank":"223","city":"Abilene","state":"Texas","population2012":"118887","population2010":"117063","land_area":"106.793","density":"1096","ansi":"2409657","location":{"lat":"32.4545","lon":"99.7381"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"224","_parent":"TX"}}
{"rank":"224","city":"Beaumont","state":"Texas","population2012":"118228","population2010":"118296","land_area":"82.801","density":"1429","ansi":"2409806","location":{"lat":"30.0843","lon":"94.1458"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"225","_parent":"CA"}}
{"rank":"225","city":"Vallejo","state":"California","population2012":"117796","population2010":"115942","land_area":"30.671","density":"3780","ansi":"2412142","location":{"lat":"38.1079","lon":"122.2639"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"226","_parent":"MO"}}
{"rank":"226","city":"Independence","state":"Missouri","population2012":"117270","population2010":"116830","land_area":"77.567","density":"1506","ansi":"2395422","location":{"lat":"39.0853","lon":"94.3513"},"abbreviation":"MO"}
{"index":{"_index":"test-data","_type":"cities","_id":"227","_parent":"IL"}}
{"rank":"227","city":"Springfield","state":"Illinois","population2012":"117126","population2010":"116250","land_area":"59.480","density":"1954","ansi":"2395940","location":{"lat":"39.7639","lon":"89.6708"},"abbreviation":"IL"}
{"index":{"_index":"test-data","_type":"cities","_id":"228","_parent":"MI"}}
{"rank":"228","city":"Ann Arbor","state":"Michigan","population2012":"116121","population2010":"113934","land_area":"27.830","density":"4094","ansi":"1625837","location":{"lat":"42.2756","lon":"83.7313"},"abbreviation":"MI"}
{"index":{"_index":"test-data","_type":"cities","_id":"229","_parent":"UT"}}
{"rank":"229","city":"Provo","state":"Utah","population2012":"115919","population2010":"112488","land_area":"41.673","density":"2699","ansi":"2411499","location":{"lat":"40.2453","lon":"111.6448"},"abbreviation":"UT"}
{"index":{"_index":"test-data","_type":"cities","_id":"230","_parent":"IL"}}
{"rank":"230","city":"Peoria","state":"Illinois","population2012":"115687","population2010":"115007","land_area":"48.007","density":"2396","ansi":"2396178","location":{"lat":"40.7523","lon":"89.6171"},"abbreviation":"IL"}
{"index":{"_index":"test-data","_type":"cities","_id":"231","_parent":"OK"}}
{"rank":"231","city":"Norman","state":"Oklahoma","population2012":"115562","population2010":"110925","land_area":"178.763","density":"621","ansi":"2411267","location":{"lat":"35.2406","lon":"97.3453"},"abbreviation":"OK"}
{"index":{"_index":"test-data","_type":"cities","_id":"232","_parent":"CA"}}
{"rank":"232","city":"Berkeley","state":"California","population2012":"115403","population2010":"112580","land_area":"10.470","density":"10752","ansi":"2409837","location":{"lat":"37.8667","lon":"122.2991"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"233","_parent":"CA"}}
{"rank":"233","city":"El Monte","state":"California","population2012":"115111","population2010":"113475","land_area":"9.562","density":"11867","ansi":"2410413","location":{"lat":"34.0746","lon":"118.0291"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"234","_parent":"TN"}}
{"rank":"234","city":"Murfreesboro","state":"Tennessee","population2012":"114038","population2010":"108755","land_area":"55.346","density":"1965","ansi":"2404342","location":{"lat":"35.8522","lon":"86.4161"},"abbreviation":"TN"}
{"index":{"_index":"test-data","_type":"cities","_id":"235","_parent":"MI"}}
{"rank":"235","city":"Lansing","state":"Michigan","population2012":"113996","population2010":"114297","land_area":"36.049","density":"3171","ansi":"1626588","location":{"lat":"42.7098","lon":"84.5562"},"abbreviation":"MI"}
{"index":{"_index":"test-data","_type":"cities","_id":"236","_parent":"MO"}}
{"rank":"236","city":"Columbia","state":"Missouri","population2012":"113225","population2010":"108500","land_area":"63.077","density":"1720","ansi":"2393605","location":{"lat":"38.9479","lon":"92.3261"},"abbreviation":"MO"}
{"index":{"_index":"test-data","_type":"cities","_id":"237","_parent":"CA"}}
{"rank":"237","city":"Downey","state":"California","population2012":"112873","population2010":"111772","land_area":"12.408","density":"9008","ansi":"2410352","location":{"lat":"33.9382","lon":"118.1309"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"238","_parent":"CA"}}
{"rank":"238","city":"Costa Mesa","state":"California","population2012":"111918","population2010":"109960","land_area":"15.654","density":"7025","ansi":"2410239","location":{"lat":"33.6659","lon":"117.9123"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"239","_parent":"CA"}}
{"rank":"239","city":"Inglewood","state":"California","population2012":"111182","population2010":"109673","land_area":"9.068","density":"12095","ansi":"2410106","location":{"lat":"33.9561","lon":"118.3443"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"240","_parent":"FL"}}
{"rank":"240","city":"Miami Gardens","state":"Florida","population2012":"110754","population2010":"107167","land_area":"18.231","density":"5878","ansi":"2404249","location":{"lat":"25.9489","lon":"80.2436"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"241","_parent":"NH"}}
{"rank":"241","city":"Manchester","state":"New Hampshire","population2012":"110209","population2010":"109565","land_area":"33.101","density":"3310","ansi":"873658","location":{"lat":"42.9847","lon":"71.4439"},"abbreviation":"NH"}
{"index":{"_index":"test-data","_type":"cities","_id":"242","_parent":"IL"}}
{"rank":"242","city":"Elgin","state":"Illinois","population2012":"109927","population2010":"108188","land_area":"37.163","density":"2911","ansi":"2394641","location":{"lat":"42.0396","lon":"88.3217"},"abbreviation":"IL"}
{"index":{"_index":"test-data","_type":"cities","_id":"243","_parent":"NC"}}
{"rank":"243","city":"Wilmington","state":"North Carolina","population2012":"109922","population2010":"106476","land_area":"51.493","density":"2068","ansi":"2405754","location":{"lat":"34.2092","lon":"77.8858"},"abbreviation":"NC"}
{"index":{"_index":"test-data","_type":"cities","_id":"244","_parent":"CT"}}
{"rank":"244","city":"Waterbury","state":"Connecticut","population2012":"109915","population2010":"110366","land_area":"28.519","density":"3870","ansi":"2378294","location":{"lat":"41.5585","lon":"73.0367"},"abbreviation":"CT"}
{"index":{"_index":"test-data","_type":"cities","_id":"245","_parent":"ND"}}
{"rank":"245","city":"Fargo","state":"North Dakota","population2012":"109779","population2010":"105549","land_area":"48.821","density":"2162","ansi":"1036030","location":{"lat":"46.8652","lon":"96.829"},"abbreviation":"ND"}
{"index":{"_index":"test-data","_type":"cities","_id":"246","_parent":"CO"}}
{"rank":"246","city":"Arvada","state":"Colorado","population2012":"109745","population2010":"106433","land_area":"35.142","density":"3029","ansi":"2409737","location":{"lat":"39.8097","lon":"105.1066"},"abbreviation":"CO"}
{"index":{"_index":"test-data","_type":"cities","_id":"247","_parent":"CA"}}
{"rank":"247","city":"Carlsbad","state":"California","population2012":"109318","population2010":"105328","land_area":"37.722","density":"2792","ansi":"2409984","location":{"lat":"33.1239","lon":"117.2828"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"248","_parent":"CO"}}
{"rank":"248","city":"Westminster","state":"Colorado","population2012":"109169","population2010":"106114","land_area":"31.550","density":"3363","ansi":"2412237","location":{"lat":"39.8822","lon":"105.0644"},"abbreviation":"CO"}
{"index":{"_index":"test-data","_type":"cities","_id":"249","_parent":"MN"}}
{"rank":"249","city":"Rochester","state":"Minnesota","population2012":"108992","population2010":"106769","land_area":"54.586","density":"1956","ansi":"2396395","location":{"lat":"44.0154","lon":"92.4772"},"abbreviation":"MN"}
{"index":{"_index":"test-data","_type":"cities","_id":"250","_parent":"OR"}}
{"rank":"250","city":"Gresham","state":"Oregon","population2012":"108956","population2010":"105594","land_area":"23.201","density":"4551","ansi":"2410663","location":{"lat":"45.5023","lon":"122.4416"},"abbreviation":"OR"}
{"index":{"_index":"test-data","_type":"cities","_id":"251","_parent":"FL"}}
{"rank":"251","city":"Clearwater","state":"Florida","population2012":"108732","population2010":"107685","land_area":"25.562","density":"4213","ansi":"2404067","location":{"lat":"27.9795","lon":"82.7663"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"252","_parent":"MA"}}
{"rank":"252","city":"Lowell","state":"Massachusetts","population2012":"108522","population2010":"106519","land_area":"13.583","density":"7842","ansi":"618227","location":{"lat":"42.6389","lon":"71.3221"},"abbreviation":"MA"}
{"index":{"_index":"test-data","_type":"cities","_id":"253","_parent":"UT"}}
{"rank":"253","city":"West Jordan","state":"Utah","population2012":"108383","population2010":"103712","land_area":"32.457","density":"3195","ansi":"2412222","location":{"lat":"40.6023","lon":"112.001"},"abbreviation":"UT"}
{"index":{"_index":"test-data","_type":"cities","_id":"254","_parent":"CO"}}
{"rank":"254","city":"Pueblo","state":"Colorado","population2012":"107772","population2010":"106595","land_area":"53.641","density":"1987","ansi":"2411501","location":{"lat":"38.2731","lon":"104.6124"},"abbreviation":"CO"}
{"index":{"_index":"test-data","_type":"cities","_id":"255","_parent":"CA"}}
{"rank":"255","city":"San Buenaventura (Ventura)","state":"California","population2012":"107734","population2010":"106433","land_area":"21.655","density":"4915","ansi":"2411779","location":{"lat":"34.2681","lon":"119.255"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"256","_parent":"CA"}}
{"rank":"256","city":"Fairfield","state":"California","population2012":"107684","population2010":"105321","land_area":"37.390","density":"2817","ansi":"2410474","location":{"lat":"38.2568","lon":"122.0397"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"257","_parent":"CA"}}
{"rank":"257","city":"West Covina","state":"California","population2012":"107440","population2010":"106098","land_area":"16.041","density":"6614","ansi":"2412219","location":{"lat":"34.0559","lon":"117.9099"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"258","_parent":"MT"}}
{"rank":"258","city":"Billings","state":"Montana","population2012":"106954","population2010":"104170","land_area":"43.413","density":"2399","ansi":"2409849","location":{"lat":"45.7895","lon":"108.5499"},"abbreviation":"MT"}
{"index":{"_index":"test-data","_type":"cities","_id":"259","_parent":"CA"}}
{"rank":"259","city":"Murrieta","state":"California","population2012":"106810","population2010":"103466","land_area":"33.577","density":"3081","ansi":"2411199","location":{"lat":"33.5719","lon":"117.1907"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"260","_parent":"NC"}}
{"rank":"260","city":"High Point","state":"North Carolina","population2012":"106586","population2010":"104371","land_area":"53.803","density":"1940","ansi":"2404696","location":{"lat":"35.9855","lon":"79.9902"},"abbreviation":"NC"}
{"index":{"_index":"test-data","_type":"cities","_id":"261","_parent":"TX"}}
{"rank":"261","city":"Round Rock","state":"Texas","population2012":"106573","population2010":"99887","land_area":"34.113","density":"2928","ansi":"2411005","location":{"lat":"30.5237","lon":"97.6674"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"262","_parent":"CA"}}
{"rank":"262","city":"Richmond","state":"California","population2012":"106516","population2010":"103701","land_area":"30.068","density":"3449","ansi":"2410939","location":{"lat":"37.953","lon":"122.3594"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"263","_parent":"MA"}}
{"rank":"263","city":"Cambridge","state":"Massachusetts","population2012":"106471","population2010":"105162","land_area":"6.385","density":"16469","ansi":"619396","location":{"lat":"42.376","lon":"71.1183"},"abbreviation":"MA"}
{"index":{"_index":"test-data","_type":"cities","_id":"264","_parent":"CA"}}
{"rank":"264","city":"Norwalk","state":"California","population2012":"106278","population2010":"105549","land_area":"9.707","density":"10873","ansi":"2411281","location":{"lat":"33.9069","lon":"118.0834"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"265","_parent":"TX"}}
{"rank":"265","city":"Odessa","state":"Texas","population2012":"106102","population2010":"99940","land_area":"41.955","density":"2382","ansi":"2411303","location":{"lat":"31.8804","lon":"102.3434"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"266","_parent":"CA"}}
{"rank":"266","city":"Antioch","state":"California","population2012":"105508","population2010":"102372","land_area":"28.349","density":"3611","ansi":"2409715","location":{"lat":"37.9775","lon":"121.7976"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"267","_parent":"CA"}}
{"rank":"267","city":"Temecula","state":"California","population2012":"105208","population2010":"100097","land_area":"30.151","density":"3320","ansi":"2412044","location":{"lat":"33.5019","lon":"117.1246"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"268","_parent":"WI"}}
{"rank":"268","city":"Green Bay","state":"Wisconsin","population2012":"104868","population2010":"104057","land_area":"45.467","density":"2289","ansi":"1583309","location":{"lat":"44.5207","lon":"87.9842"},"abbreviation":"WI"}
{"index":{"_index":"test-data","_type":"cities","_id":"269","_parent":"WA"}}
{"rank":"269","city":"Everett","state":"Washington","population2012":"104655","population2010":"103019","land_area":"33.447","density":"3080","ansi":"2410469","location":{"lat":"48.0033","lon":"122.1742"},"abbreviation":"WA"}
{"index":{"_index":"test-data","_type":"cities","_id":"270","_parent":"TX"}}
{"rank":"270","city":"Wichita Falls","state":"Texas","population2012":"104552","population2010":"104553","land_area":"72.140","density":"1449","ansi":"2412261","location":{"lat":"33.9067","lon":"98.5259"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"271","_parent":"CA"}}
{"rank":"271","city":"Burbank","state":"California","population2012":"104391","population2010":"103340","land_area":"17.341","density":"5959","ansi":"2409939","location":{"lat":"34.189","lon":"118.3249"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"272","_parent":"FL"}}
{"rank":"272","city":"Palm Bay","state":"Florida","population2012":"104124","population2010":"103190","land_area":"65.702","density":"1571","ansi":"2404463","location":{"lat":"27.9856","lon":"80.6626"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"273","_parent":"CO"}}
{"rank":"273","city":"Centennial","state":"Colorado","population2012":"103743","population2010":"100377","land_area":"28.722","density":"3495","ansi":"2409422","location":{"lat":"39.5906","lon":"104.8691"},"abbreviation":"CO"}
{"index":{"_index":"test-data","_type":"cities","_id":"274","_parent":"CA"}}
{"rank":"274","city":"Daly City","state":"California","population2012":"103690","population2010":"101123","land_area":"7.664","density":"13195","ansi":"2410291","location":{"lat":"37.7009","lon":"122.465"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"275","_parent":"TX"}}
{"rank":"275","city":"Richardson","state":"Texas","population2012":"103297","population2010":"99223","land_area":"28.564","density":"3474","ansi":"2410933","location":{"lat":"32.9723","lon":"96.7081"},"abbreviation":"TX"}
{"index":{"_index":"test-data","_type":"cities","_id":"276","_parent":"FL"}}
{"rank":"276","city":"Pompano Beach","state":"Florida","population2012":"102984","population2010":"99845","land_area":"24.002","density":"4160","ansi":"2404547","location":{"lat":"26.2426","lon":"80.129"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"277","_parent":"OK"}}
{"rank":"277","city":"Broken Arrow","state":"Oklahoma","population2012":"102019","population2010":"98850","land_area":"61.571","density":"1605","ansi":"2409914","location":{"lat":"36.0365","lon":"95.781"},"abbreviation":"OK"}
{"index":{"_index":"test-data","_type":"cities","_id":"278","_parent":"SC"}}
{"rank":"278","city":"North Charleston","state":"South Carolina","population2012":"101989","population2010":"97471","land_area":null,"density":null,"ansi":null,"location":{"lat":"32.8853","lon":"80.0169"},"abbreviation":"SC"}
{"index":{"_index":"test-data","_type":"cities","_id":"279","_parent":"FL"}}
{"rank":"279","city":"West Palm Beach","state":"Florida","population2012":"101903","population2010":"99919","land_area":"55.293","density":"1807","ansi":"2405713","location":{"lat":"26.7483","lon":"80.1266"},"abbreviation":"FL"}
{"index":{"_index":"test-data","_type":"cities","_id":"280","_parent":"CO"}}
{"rank":"280","city":"Boulder","state":"Colorado","population2012":"101808","population2010":"97385","land_area":null,"density":null,"ansi":null,"location":{"lat":"40.0175","lon":"105.2797"},"abbreviation":"CO"}
{"index":{"_index":"test-data","_type":"cities","_id":"281","_parent":"CA"}}
{"rank":"281","city":"Rialto","state":"California","population2012":"101740","population2010":"99171","land_area":"22.351","density":"4437","ansi":"2410931","location":{"lat":"34.1118","lon":"117.3883"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"282","_parent":"CA"}}
{"rank":"282","city":"Santa Maria","state":"California","population2012":"101459","population2010":"99553","land_area":"22.756","density":"4375","ansi":"2411824","location":{"lat":"34.9332","lon":"120.4438"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"283","_parent":"CA"}}
{"rank":"283","city":"El Cajon","state":"California","population2012":"101435","population2010":"99478","land_area":"14.433","density":"6892","ansi":"2410406","location":{"lat":"32.8017","lon":"116.9605"},"abbreviation":"CA"}
{"index":{"_index":"test-data","_type":"cities","_id":"284","_parent":"IA"}}
{"rank":"284","city":"Davenport","state":"Iowa","population2012":"101363","population2010":"99685","land_area":"62.948","density":"1584","ansi":"2394467","location":{"lat":"41.5541","lon":"90.604"},"abbreviation":"IA"}
{"index":{"_index":"test-data","_type":"cities","_id":"285","_parent":"PA"}}
{"rank":"285","city":"Erie","state":"Pennsylvania","population2012":"101047","population2010":"101786","land_area":"19.081","density":"5334","ansi":"1215209","location":{"lat":"42.1166","lon":"80.0735"},"abbreviation":"PA"}
{"index":{"_index":"test-data","_type":"cities","_id":"286","_parent":"NM"}}
{"rank":"286","city":"Las Cruces","state":"New Mexico","population2012":"101047","population2010":"97618","land_area":"76.290","density":"1279","ansi":null,"location":{"lat":"32.3197","lon":"106.7653"},"abbreviation":"NM"}
{"index":{"_index":"test-data","_type":"cities","_id":"287","_parent":"IN"}}
{"rank":"287","city":"South Bend","state":"Indiana","population2012":"100800","population2010":"101168","land_area":"41.458","density":"2440","ansi":"2395913","location":{"lat":"41.6769","lon":"86.269"},"abbreviation":"IN"}
{"index":{"_index":"test-data","_type":"cities","_id":"288","_parent":"MI"}}
{"rank":"288","city":"Flint","state":"Michigan","population2012":"100515","population2010":"102434","land_area":"33.416","density":"3065","ansi":"1626285","location":{"lat":"43.0244","lon":"83.692"},"abbreviation":"MI"}
{"index":{"_index":"test-data","_type":"cities","_id":"289","_parent":"WI"}}
{"rank":"289","city":"Kenosha","state":"Wisconsin","population2012":"100150","population2010":"99218","land_area":null,"density":null,"ansi":null,"location":{"lat":"42.5822","lon":"87.8456"},"abbreviation":"WI"}
'
echo
