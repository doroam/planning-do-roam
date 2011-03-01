# To change this template, choose Tools | Templates
# and open the template in the editor.

class Global
  GLOBAL_FIELD_NAME = 'name'
  GLOBAL_FIELD_AMENITY = 'amenity'
  GLOBAL_TABLE_POINT = 'planet_osm_point'
  GLOBAL_TABLE_POLYGON = 'planet_osm_polygon'
  GLOBAL_FIELD_POINT_GEOM = 'way'
  GLOBAL_FIELD_LONG = 'X(st_centroid(transform('+GLOBAL_FIELD_POINT_GEOM+',4326)))'
  GLOBAL_FIELD_LAT =  'Y(st_centroid(transform('+GLOBAL_FIELD_POINT_GEOM+',4326)))'
  GLOBAL_FIELD_ROAD_GEOM = 'the_geom'
  GLOBAL_FIELD_START_POINT_LONG = "x(startpoint(transform("+GLOBAL_FIELD_ROAD_GEOM+",4326))) as start_long"
  GLOBAL_FIELD_START_POINT_LAT = "y(startpoint(transform("+GLOBAL_FIELD_ROAD_GEOM+",4326))) as start_lat"
  GLOBAL_FIELD_END_POINT_LONG = "x(endpoint(transform("+GLOBAL_FIELD_ROAD_GEOM+",4326))) as end_long"
  GLOBAL_FIELD_END_POINT_LAT = "y(endpoint(transform("+GLOBAL_FIELD_ROAD_GEOM+",4326))) as end_lat"
  
  IMAGE_URL_PREFIX = "images/icons/"
  IMAGE_URL_SUFFIX = ".png"  
  IMAGE_URLS = {
    "doctors"=>"aertze",
    "pharmacy"=>"apotheke",
    "bakery"=>"bakery",
    "bank"=>"bank",
    "argingStation"=>"battery", "chargingStation"=>"battery",
    "school"=>"bildungseinrichtungen",
    "bus_stop"=>"busstop",
    "cafe"=>"cafe",
    "car sharing"=>"carshare",
    "kindergarten"=>"childcare",
    "doctors"=>"doctor",
    "education"=>"education",
    "fast_food"=>"fastfood",
    "fuel"=>"fuel",
    "restaurant"=>"gastronomie",
    "atm"=>"geldautomat",
    "hospital"=>"hospital",
    "cinema"=>"kino",
    "parking"=>"parking",
    "police"=>"police",
    "restaurant"=>"restaurant",
    "theatre"=>"theater"    
  }  
end
