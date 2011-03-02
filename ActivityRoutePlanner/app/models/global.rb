# To change this template, choose Tools | Templates
# and open the template in the editor.

class Global
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
  GLOBAL_FIELD_START_POINT_LONG       = 'x(startpoint('+GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM+')) as start_long'
  GLOBAL_FIELD_START_POINT_LAT        = 'y(startpoint('+GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM+')) as start_lat'
  GLOBAL_FIELD_END_POINT_LONG         = 'x(endpoint('+GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM+')) as end_long'
  GLOBAL_FIELD_END_POINT_LAT          = 'y(endpoint('+GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM+')) as end_lat'
  
  ALGORITHMUS_LIST = ["A*","Dijkstra"]
  
  IMAGE_URL_PREFIX = "images/icons/"
  IMAGE_URL_SUFFIX = ".png"  
  IMAGE_URLS = {
    "amenity$pharmacy"=>"apotheke",
    "amenity$bakery"=>"bakery",
    "amenity$bank"=>"bank",
    "amenity$chargingStation"=>"battery",
    "amenity$school"=>"bildungseinrichtungen",
    "amenity$bus_stop"=>"busstop",
    "amenity$cafe"=>"cafe",
    "amenity$car sharing"=>"carshare",
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
    "sport$bowling"=>"bowling",
    "sport$swimming"=>"swimming",
    "sport$soccer"=>"soccer",
    "sport$climbing"=>"climbing",
    "sport$golf"=>"golfcourse"
  } 
  
ACTIVITIES = [
      Activity.new("amenity", "pharmacy"),
      Activity.new("amenity", "bakery"),
      Activity.new("amenity", "bank"),
      Activity.new("amenity", "chargingStation"),  
      Activity.new("amenity", "school"),
      Activity.new("amenity", "bus_stop"),
      Activity.new("amenity", "cafe"),
      Activity.new("amenity", "car sharing"),
      Activity.new("amenity", "kindergarten"),
      Activity.new("amenity", "doctors"),
      Activity.new("amenity", "education"),
      Activity.new("amenity", "fast_food"),
      Activity.new("amenity", "fuel"),
      Activity.new("amenity", "atm"),
      Activity.new("amenity", "hospital"),
      Activity.new("amenity", "cinema"),  
      Activity.new("amenity", "parking"),
      Activity.new("amenity", "police"),
      Activity.new("amenity", "restaurant"),
      Activity.new("amenity", "theatre"),
      
      Activity.new("sport", "bowling"),
      Activity.new("sport", "swimming"),
      Activity.new("sport", "soccer"),
      Activity.new("sport", "climbing"),
      Activity.new("sport", "golf")
]  
end
