# To change this template, choose Tools | Templates
# and open the template in the editor.

class Global
  GLOBAL_FIELD_NAME = 'name'
  GLOBAL_FIELD_AMENITY = 'amenity'
  GLOBAL_TABLE_POINT = 'planet_osm_point'
  GLOBAL_TABLE_POLYGON = 'planet_osm_polygon'
  GLOBAL_FIELD_LONG = 'X(st_centroid(transform(way,4326)))'
  GLOBAL_FIELD_LAT =  'Y(st_centroid(transform(way,4326)))'
  GLOBAL_FIELD_START_POINT_LONG = "x(startpoint(transform(the_geom,4326))) as start_long"
  GLOBAL_FIELD_START_POINT_LAT = "y(startpoint(transform(the_geom,4326))) as start_lat"
  GLOBAL_FIELD_END_POINT_LONG = "x(endpoint(transform(the_geom,4326))) as end_long"
  GLOBAL_FIELD_END_POINT_LAT = "y(endpoint(transform(the_geom,4326))) as end_lat"
  
  IMAGE_URL_PREFIX = "images/icons/"
  IMAGE_URL_SUFFIX = ".png"  
  IMAGE_URLS = {
    "amenity_pharmacy"=>"apotheke",
    "amenity_bakery"=>"bakery",
    "amenity_bank"=>"bank",
    "amenity_chargingStation"=>"battery",
    "amenity_school"=>"bildungseinrichtungen",
    "amenity_bus_stop"=>"busstop",
    "amenity_cafe"=>"cafe",
    "amenity_car sharing"=>"carshare",
    "amenity_kindergarten"=>"childcare",
    "amenity_doctors"=>"doctor",
    "amenity_education"=>"education",
    "amenity_fast_food"=>"fastfood",
    "amenity_fuel"=>"fuel",
    "amenity_atm"=>"geldautomat",
    "amenity_hospital"=>"hospital",
    "amenity_cinema"=>"kino",
    "amenity_parking"=>"parking",
    "amenity_police"=>"police",
    "amenity_restaurant"=>"restaurant",
    "amenity_theatre"=>"theater",
    "sport_bowling"=>"bowling",
    "sport_swimming"=>"swimming",
    "sport_soccer"=>"soccer",
    "sport_climbing"=>"climbing",
    "sport_golf"=>"golfcourse"
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
