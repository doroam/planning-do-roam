#class for constants
class Global
  # database constants
  GLOBAL_FIELD_NAME                   = 'name'
  GLOBAL_FIELD_AMENITY                = 'amenity'
  GLOBAL_TABLE_POINT                  = 'planet_osm_point'
  GLOBAL_TABLE_POLYGON                = 'planet_osm_polygon'
  GLOBAL_FIELD_POINT_GEOM             = 'way'
  GLOBAL_FIELD_TRANSFORMED_POINT_GEOM = 'transform('+GLOBAL_FIELD_POINT_GEOM+',4326)'
  GLOBAL_FIELD_LONG                   = 'X(st_centroid('+GLOBAL_FIELD_TRANSFORMED_POINT_GEOM+'))'
  GLOBAL_FIELD_LAT                    = 'Y(st_centroid('+GLOBAL_FIELD_TRANSFORMED_POINT_GEOM+'))'

  GLOBAL_FIELD_ROAD_GEOM              = 'the_geom'
  GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM  = 'transform('+GLOBAL_FIELD_ROAD_GEOM+',4326)'
  GLOBAL_ALIAS_START_POINT_LONG       = 'start_long'
  GLOBAL_ALIAS_START_POINT_LAT        = 'start_lat'
  GLOBAL_ALIAS_END_POINT_LONG         = 'end_long'
  GLOBAL_ALIAS_END_POINT_LAT          = 'end_lat'
  GLOBAL_FIELD_SOURCE                 = 'source'
  GLOBAL_FIELD_TARGET                 = 'target'
  GLOBAL_FIELD_START_POINT_LONG       = 'x(startpoint('+GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM+')) as '+GLOBAL_ALIAS_START_POINT_LONG
  GLOBAL_FIELD_START_POINT_LAT        = 'y(startpoint('+GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM+')) as '+GLOBAL_ALIAS_START_POINT_LAT
  GLOBAL_FIELD_END_POINT_LONG         = 'x(endpoint('+GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM+')) as '+GLOBAL_ALIAS_END_POINT_LONG
  GLOBAL_FIELD_END_POINT_LAT          = 'y(endpoint('+GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM+')) as '+GLOBAL_ALIAS_END_POINT_LAT


  GLOBAL_FIELD_TYPE                   = 'type_name'
  
  #constants to map the activities to icons
  IMAGE_URL_PREFIX = "images/icons/"
  IMAGE_URL_SUFFIX = ".png"  
  IMAGE_URLS = {
    "tourism$museum" => "museum",
    "tourism$hotel" => "hotel",
    "leisure$sports_centre" => "fitness",
    "railway$station" => "trainstation",
    "religion$christian" => "christian",
    "railway$tram_stop" => "busstop",
    "amenity$library" => "library",
    "amenity$charging_station" => "battery",
    "amenity$post_office" => "post_office",
    "amenity$nightclub" => "dance",
    "amenity$pharmacy"=>"apotheke",
    "amenity$bakery"=>"bakery",
    "amenity$bank"=>"bank",
    "amenity$school"=>"bildungseinrichtungen",
    "amenity$cafe"=>"cafe",
    "amenity$kindergarten"=>"childcare",
    "amenity$doctors"=>"doctor",
    "amenity$education"=>"education",
    "amenity$fast_food"=>"fastfood",
    "amenity$fuel"=>"fuel",
    "amenity$atm"=>"geldautomat",
    "amenity$hospital"=>"hospital",
    "amenity$cinema"=>"kino",
    "amenity$parking"=>"parking",
    "amenity$police"=>"police",
    "amenity$restaurant"=>"restaurant",
    "amenity$theatre"=>"theater",
    "amenity$shop"=>"mall",
    "sport$bowling"=>"bowling",
    "sport$swimming"=>"swimming",
    "sport$soccer"=>"soccer",
    "sport$climbing"=>"climbing",
    "sport$golf"=>"golfcourse",
    "historic$castle"=>"castles"
  } 
#list of activities with tag and value in the database
ACTIVITIES = [
      Selection.new("tourism", "museum"),
      Selection.new("tourism", "hotel"),
      Selection.new("leisure", "sports_centre"),
      Selection.new("railway", "station"),
      Selection.new("railway", "tram_stop"),
      Selection.new("amenity", "library"),
      Selection.new("amenity", "post_office"),
      Selection.new("amenity", "nightclub"),
      Selection.new("amenity", "pharmacy"),
      Selection.new("amenity", "bakery"),
      Selection.new("amenity", "bank"),
      Selection.new("amenity", "school"),
      Selection.new("amenity", "cafe"),
      Selection.new("amenity", "kindergarten"),
      Selection.new("amenity", "doctors"),
      Selection.new("amenity", "education"),
      Selection.new("amenity", "fast_food"),
      Selection.new("amenity", "fuel"),
      Selection.new("amenity", "atm"),
      Selection.new("amenity", "hospital"),
      Selection.new("amenity", "cinema"),
      Selection.new("amenity", "parking"),
      Selection.new("amenity", "police"),
      Selection.new("amenity", "restaurant"),
      Selection.new("amenity", "theatre"),
      
      Selection.new("sport", "bowling"),
      Selection.new("sport", "swimming"),
      Selection.new("sport", "soccer"),
      Selection.new("sport", "climbing"),
      Selection.new("sport", "golf")
]  
end
