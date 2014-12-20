#!/bin/bash
#
# This script demonstrates how to perform nested histogram aggs
#
curl -XDELETE localhost:9200/microsoft
curl -XPUT localhost:9200/microsoft -d '{
    "settings": {
        "index.number_of_shards": 1,
        "index.number_of_replicas": 0
    },
    "mappings": {
        "acquisition": {
            "_id": {
                "path": "id"
            },
            "properties": {
                "id": {
                    "type": "integer"
                },
                "date": {
                    "type": "date",
                    "format": "dd-MMM-yy"
                },
                "company": {
                    "type": "string"
                },
                "business": {
                    "type": "string",
                    "index": "not_analyzed"
                },
                "price": {
                    "type": "integer"
                }
            }
        }
    }
}
'

curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":1, "date":"30-Jul-87", "company":"Forethought", "business":"Computer software", "country": "United States", "price": 14000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":2, "date":"31-Mar-91", "company":"Consumers Software", "business":"Software", "country": "Canada", "price": 20500000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":3, "date":"29-Jun-92", "company":"Fox Software", "business":"PC database software", "country": "United States", "price": 174800000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":4, "date":"28-Feb-94", "company":"Softimage", "business":"Wholesale 3-D visualization software", "country": "Canada", "price": 139000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":5, "date":"27-Sep-94", "company":"Altamira Software", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":6, "date":"1-Nov-94", "company":"NextBase", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":7, "date":"15-Nov-94", "company":"One Tree Software", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":8, "date":"23-Feb-95", "company":"RenderMorphics", "business":"3D graphics hardware", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":9, "date":"10-Jul-95", "company":"Network Managers", "business":"Systems design", "country": "United Kingdom"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":10, "date":"17-Oct-95", "company":"Blue Ribbon Soundworks", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":11, "date":"6-Nov-95", "company":"Netwise", "business":"Computer software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":12, "date":"12-Dec-95", "company":"Bruce ArtwickOrganization", "business":"Programming", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":13, "date":"16-Jan-96", "company":"Vermeer Technologies", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":14, "date":"6-Mar-96", "company":"VGA-Animation Software Div[note 1]", "business":"Software", "country": "Germany"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":15, "date":"12-Mar-96", "company":"Colusa Software", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":16, "date":"16-Apr-96", "company":"Exos", "business":"Video game controllers", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":17, "date":"23-Apr-96", "company":"Aspect Software Engineering", "business":"Computer software", "country": "United States", "price": 14150000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":18, "date":"11-Jun-96", "company":"eShop", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":19, "date":"17-Jun-96", "company":"Electric Gravity", "business":"Electronic games", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":20, "date":"1-Nov-96", "company":"Panorama Software Sys-On-Line[note 2]", "business":"Software", "country": "Canada"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":21, "date":"3-Feb-97", "company":"NetCarta", "business":"Internet software", "country": "United States", "price": 20000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":22, "date":"3-Mar-97", "company":"Interse", "business":"Internet software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":23, "date":"30-Apr-97", "company":"WebTV Networks", "business":"Internet service provider", "country": "United States", "price": 425000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":24, "date":"7-May-97", "company":"Dimension X", "business":"Java-based platforms", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":25, "date":"13-Jun-97", "company":"Cooper & Peters", "business":"Programming", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":26, "date":"30-Jun-97", "company":"LinkAge Software", "business":"Internet software development", "country": "Canada"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":27, "date":"5-Aug-97", "company":"VXtreme", "business":"Internet video software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":28, "date":"31-Dec-97", "company":"Hotmail", "business":"Internet software", "country": "United States", "price": 500000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":29, "date":"23-Feb-98", "company":"Flash Communications", "business":"Enterprise instant messaging software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":30, "date":"15-Apr-98", "company":"Firefly", "business":"Relationship management software", "country": "United States", "price": 40000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":31, "date":"28-Apr-98", "company":"MESA Group", "business":"Data sharing software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":32, "date":"25-Aug-98", "company":"Valence Research", "business":"Internet software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":33, "date":"6-Nov-98", "company":"LinkExchange", "business":"Internet advertising network", "country": "United States", "price": 265000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":34, "date":"11-Jan-99", "company":"FASA Interactive", "business":"Computer game software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":35, "date":"4-Mar-99", "company":"CompareNet", "business":"Shopping online", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":36, "date":"26-Mar-99", "company":"Numinous Technologies", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":37, "date":"27-Apr-99", "company":"Interactive Objects-Digital", "business":"Web music software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":38, "date":"30-Apr-99", "company":"Jump Networks", "business":"Internet service provider", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":39, "date":"7-Jun-99", "company":"ShadowFactor Software", "business":"Wholesale computer software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":40, "date":"15-Jun-99", "company":"Omnibrowse", "business":"Internet software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":41, "date":"28-Jun-99", "company":"Intrinsa", "business":"Defect detection software", "country": "United States", "price": 58900000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":42, "date":"1-Jul-99", "company":"Sendit", "business":"Application software", "country": "Sweden", "price": 125420000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":43, "date":"7-Jul-99", "company":"Zoomit", "business":"Encryption software", "country": "Canada"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":44, "date":"21-Jul-99", "company":"STNC", "business":"Community software", "country": "United Kingdom"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":45, "date":"19-Sep-99", "company":"Softway Systems", "business":"Computer programming", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":46, "date":"29-Oct-99", "company":"Entropic", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":47, "date":"7-Jan-00", "company":"Visio Corporation", "business":"Wholesale drawing software", "country": "United States", "price": 1375000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":48, "date":"29-Feb-00", "company":"Peach Networks", "business":"Digital TV services", "country": "Israel"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":49, "date":"17-Mar-00", "company":"Travelscape", "business":"Internet service provider", "country": "United States", "price": 89750000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":50, "date":"12-Apr-00", "company":"Titus Communications", "business":"Cable television", "country": "United States", "price": 944800000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":51, "date":"19-Jun-00", "company":"Bungie Software", "business":"Computer software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":52, "date":"12-Jul-00", "company":"NetGames", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":53, "date":"13-Sep-00", "company":"MongoMusic", "business":"Online music search engine", "country": "United States", "price": 65000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":54, "date":"27-Sep-00", "company":"Pacific Microsonics", "business":"Digital audio technology", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":55, "date":"17-Mar-01", "company":"Vacationspot", "business":"Internet service provider", "country": "United States", "price": 70850000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":56, "date":"5-Apr-01", "company":"Great Plains Software", "business":"Business management software", "country": "United States", "price": 939884000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":57, "date":"2-May-01", "company":"Intellisol International", "business":"Software", "country": "Canada"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":58, "date":"31-May-01", "company":"NCompass Labs", "business":"Internet software", "country": "Canada", "price": 36000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":59, "date":"21-Jun-01", "company":"Maximal Innovative Intelligence", "business":"Software", "country": "Israel", "price": 20000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":60, "date":"1-Jul-01", "company":"Yupi", "business":"Online Spanish Portal", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":61, "date":"11-Mar-02", "company":"Classic Custom Vacations", "business":"Travel agency", "country": "United States", "price": 78000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":62, "date":"22-May-02", "company":"Sales Management Systems", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":63, "date":"12-Jul-02", "company":"Navision", "business":"Software programming", "country": "Denmark", "price": 1330000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":64, "date":"29-Jul-02", "company":"Mobilocity", "business":"Computer consulting", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":65, "date":"10-Sep-02", "company":"XDegrees", "business":"Security software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":66, "date":"24-Sep-02", "company":"Rare", "business":"Software and video games", "country": "United Kingdom", "price": 375000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":67, "date":"13-Dec-02", "company":"Vicinity", "business":"Online enterprise location", "country": "United States", "price": 95849000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":68, "date":"25-Feb-03", "company":"Connectix", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":69, "date":"3-Mar-03", "company":"DCG", "business":"Internet software", "country": "Australia"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":70, "date":"30-Apr-03", "company":"PlaceWare", "business":"Web conferencing", "country": "United States", "price": 200000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":71, "date":"27-May-03", "company":"G.A. Sullivan", "business":"Information technology", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":72, "date":"10-Jun-03", "company":"GeCAD Software", "business":"Antivirus technology", "country": "Romania"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":73, "date":"29-Aug-03", "company":"3DOCo-High Heat Baseball", "business":"Software", "country": "United States", "price": 450000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":74, "date":"22-Apr-04", "company":"Encore Bus Solutions-IP Asts", "business":"IP assets", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":75, "date":"26-Apr-04", "company":"ActiveViews", "business":"Reporting systems", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":76, "date":"16-Jul-04", "company":"Lookout Software", "business":"Personal search tool", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":77, "date":"16-Dec-04", "company":"GIANT Company Software", "business":"Anti-spyware", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":78, "date":"2-Mar-05", "company":"en'\''tegrate", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":79, "date":"9-Apr-05", "company":"Groove Networks", "business":"Community software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":80, "date":"11-May-05", "company":"MessageCast", "business":"Messaging", "country": "United States", "price": 7000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":81, "date":"31-May-05", "company":"Tsinghua-Shenxun-Cert Asts", "business":"Certain assets", "country": "China", "price": 15000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":82, "date":"21-Jun-05", "company":"Sybari Software", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":83, "date":"29-Aug-05", "company":"Teleo", "business":"VoIP", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":84, "date":"31-Aug-05", "company":"FrontBridge Technologies", "business":"Email protection", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":85, "date":"19-Sep-05", "company":"Alacris", "business":"Certificate management software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":86, "date":"3-Nov-05", "company":"media-streams.com", "business":"Software", "country": "Switzerland"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":87, "date":"17-Nov-05", "company":"5th Finger", "business":"Mobile", "country": "Australia", "price": 3153000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":88, "date":"19-Jan-06", "company":"UMT-Software and IP Assets", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":89, "date":"13-Feb-06", "company":"MotionBridge", "business":"Search", "country": "France", "price": 17858000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":90, "date":"13-Feb-06", "company":"Seadragon Software", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":91, "date":"7-Mar-06", "company":"Apptimum", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":92, "date":"7-Mar-06", "company":"Onfolio", "business":"Internet software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":93, "date":"6-Apr-06", "company":"Lionhead Studios", "business":"Video games", "country": "United Kingdom"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":94, "date":"26-Apr-06", "company":"AssetMetrix", "business":"Enterprise software", "country": "Canada"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":95, "date":"4-May-06", "company":"Massive Incorporated", "business":"Video game advertising", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":96, "date":"4-May-06", "company":"Vexcel", "business":"Mapping software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":97, "date":"15-May-06", "company":"DeepMetrix", "business":"Web log analysis", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":98, "date":"6-Jun-06", "company":"ProClarity", "business":"Analysis software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":99, "date":"27-Jun-06", "company":"iView Multimedia", "business":"Digital asset management", "country": "United Kingdom"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":100, "date":"17-Jul-06", "company":"Softricity", "business":"application virtualization software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":101, "date":"18-Jul-06", "company":"WinternalsSoftware", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":102, "date":"26-Jul-06", "company":"Whale Communications", "business":"Applications", "country": "Israel"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":103, "date":"26-Sep-06", "company":"Gteko", "business":"Applications", "country": "Israel"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":104, "date":"2-Oct-06", "company":"DesktopStandard", "business":"Applications", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":105, "date":"12-Oct-06", "company":"Colloquis", "business":"Natural language software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":106, "date":"9-Mar-07", "company":"Medstory", "business":"Internet search engine", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":107, "date":"26-Mar-07", "company":"devBiz Business Solutions", "business":"Software tools", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":108, "date":"3-May-07", "company":"ScreenTonic", "business":"Advertising and marketing", "country": "France"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":109, "date":"3-May-07", "company":"Tellme Networks", "business":"Mobile phone software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":110, "date":"9-May-07", "company":"SoftArtisans", "business":"Business Intelligence software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":111, "date":"4-Jun-07", "company":"Engyro", "business":"Information technology", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":112, "date":"7-Jun-07", "company":"Stratature", "business":"Master Data Management", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":113, "date":"29-Jun-07", "company":"Savvis Inc-Data Centers", "business":"Networking", "country": "United States", "price": 200000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":114, "date":"13-Aug-07", "company":"AdECN", "business":"Ad Exchange", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":115, "date":"13-Aug-07", "company":"aQuantive", "business":"Digital marketing", "country": "United States", "price": 6333000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":116, "date":"2-Oct-07", "company":"Jellyfish.com", "business":"Search engine", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":117, "date":"5-Oct-07", "company":"Parlano", "business":"Enterprise messaging software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":118, "date":"29-Oct-07", "company":"Global Care Solutions-Assets", "business":"Assets", "country": "Thailand"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":119, "date":"1-Nov-07", "company":"HOB Business Solutions", "business":"Information technology", "country": "Denmark"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":120, "date":"15-Nov-07", "company":"Musiwave", "business":"Mobile music entertainment", "country": "France"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":121, "date":"12-Dec-07", "company":"Multimap.com", "business":"Mapping", "country": "United Kingdom"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":122, "date":"22-Jan-08", "company":"Calista Technologies", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":123, "date":"7-Feb-08", "company":"Caligari Corporation", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":124, "date":"27-Feb-08", "company":"YaData", "business":"Software", "country": "Israel"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":125, "date":"14-Mar-08", "company":"Rapt", "business":"Advertising yield management software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":126, "date":"19-Mar-08", "company":"Komoku", "business":"Rootkit security software", "country": "United States", "price": 5000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":127, "date":"31-Mar-08", "company":"90 Degree Software", "business":"Business intelligence software", "country": "Canada"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":128, "date":"14-Apr-08", "company":"Farecast", "business":"Online search software", "country": "United States", "price": 75000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":129, "date":"15-Apr-08", "company":"Danger", "business":"Mobile Internet software", "country": "United States", "price": 500000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":130, "date":"25-Apr-08", "company":"Fast Search & Transfer", "business":"Enterprise search[clarification needed]", "country": "Norway", "price": 1191000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":131, "date":"26-May-08", "company":"Kidaro", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":132, "date":"4-Jun-08", "company":"Quadreon", "business":"Software", "country": "Belgium"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":133, "date":"18-Jun-08", "company":"Navic Networks", "business":"Management software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":134, "date":"26-Jun-08", "company":"Mobicomp", "business":"Mobile applications", "country": "Portugal"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":135, "date":"11-Aug-08", "company":"Powerset", "business":"Semantic Search", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":136, "date":"16-Sep-08", "company":"DATAllegro", "business":"Data software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":137, "date":"28-Sep-08", "company":"Greenfield Online", "business":"Search and e-commerce services", "country": "United States", "price": 486000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":138,1-Mar-09, "date":"3DV Systems", "company":""Developer ofZCam", "business":" atime-of-flightcamera"", "country": "Israel", "price": 35000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":139, "date":"7-May-09", "company":"BigPark", "business":"Interactive online gaming", "country": "Canada"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":140, "date":"1-Jun-09", "company":"Rosetta Biosoftware", "business":"Bioinformatics solutions for life science research", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":141, "date":"22-Sep-09", "company":"Interactive Supercomputing", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":142, "date":"10-Dec-09", "company":"Opalis Software", "business":"Software", "country": "Canada"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":143, "date":"10-Dec-09", "company":""Sentillion", "business":" Inc."", "country": "Identity and Access Management Software for Healthcare", "price": United States,}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":144, "date":"6-Oct-10", "company":""AVIcode", "business":" Inc."", "country": ".Net monitoring technology", "price": United States,}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":145, "date":"29-Oct-10", "company":""Canesta", "business":" Inc."", "country": "3-D sensing technology", "price": United States,}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":146, "date":"10-May-11", "company":"Skype Technologies", "business":"Telecommunications", "country": "Luxembourg", "price": 8500000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":147, "date":"7-Jun-11", "company":"Prodiance", "business":"Software", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":148, "date":"22-Nov-11", "company":"Videosurf", "business":"Video search", "country": "United States", "price": 100000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":149, "date":"25-Jun-12", "company":"Yammer", "business":"Social networking", "country": "United States", "price": 1200000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":150, "date":"9-Jul-12", "company":"Perceptive Pixel", "business":"Multi touch hardware", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":151, "date":"4-Oct-12", "company":"PhoneFactor", "business":"Two-factor authentication system", "country": ""}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":152, "date":"16-Oct-12", "company":"StorSimple", "business":"Cloud-storage appliance vendor", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":153, "date":"17-Oct-12", "company":"MarketingPilot", "business":"Marketing automation firm", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":154, "date":"3-Jan-13", "company":"id8 Group R2 Studios", "business":"Home automation", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":155, "date":"4-Mar-13", "company":"MetricsHub", "business":"Cloud monitoring", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":156, "date":"19-Mar-13", "company":"Netbreeze", "business":"Social analytics", "country": "Switzerland"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":157, "date":"3-Jun-13", "company":"InRelease", "business":"Release management", "country": ""}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":158,2-Sep-13, "date":"Nokiamobile phones unit", "company":""Mobile phones", "business":"smartphones"", "country": "Finland", "price": 7200000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":159, "date":"12-Oct-13", "company":"HLW Software", "business":"RDP applications", "country": "Austria"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":160, "date":"25-Oct-13", "company":"Apiphany", "business":"API management", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":161, "date":"7-Jan-14", "company":"Parature", "business":"Customer service software", "country": "United States", "price": 100000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":162, "date":"1-May-14", "company":"GreenButton", "business":"Cloud computing", "country": "New Zealand"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":163, "date":"1-May-14", "company":"Capptain", "business":"(Mobile) application development", "country": "France"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":164, "date":"2-Jul-14", "company":"SyntaxTree", "business":"Developer tools", "country": "France"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":165, "date":"11-Jul-14", "company":"InMage", "business":"Disaster recovery solutions", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":166, "date":"6-Nov-14", "company":"Mojang", "business":"Computer software", "country": "Sweden", "price": 2500000000}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":167, "date":"13-Nov-14", "company":"Aorato", "business":"Enterprise Security & machine learning", "country": "Israel"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":168, "date":"2-Dec-14", "company":"Acompli", "business":"Mobile Email Apps", "country": "United States"}'
curl -XPOST "localhost:9200/microsoft/acquisition" -d '{"id":169, "date":"11-Dec-14", "company":"HockeyApp", "business":"Mobile Beta Distribution & Crash Analytics", "country": "Germany"}'
curl -XPOST "localhost:9200/microsoft/_refresh?pretty"
curl "localhost:9200/microsoft/acquisition/_search?pretty&search_type=count" -d '{
    "aggs": {
        "acquisition_with_known_price": { 
            "filter": {
                "exists": {
                    "field": "price"
                }
            },
            "aggs": {
                "by_year": {
                    "date_histogram": {
                        "field": "date",
                        "interval": "year"
                    },
                    "aggs": {
                        "avarage_price": {
                            "avg": {
                                "field": "price"
                            }
                        }
                    }
                }
            }
        }
    }
}'
