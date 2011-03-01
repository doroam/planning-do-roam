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
    "amenity_doctors"=>"aertze",
    "amenity_pharmacy"=>"apotheke",
    "amenity_bakery"=>"bakery",
    "amenity_bank"=>"bank",
    "amenity_argingStation"=>"battery", "chargingStation"=>"battery",
    "amenity_school"=>"bildungseinrichtungen",
    "amenity_bus_stop"=>"busstop",
    "amenity_cafe"=>"cafe",
    "amenity_car sharing"=>"carshare",
    "amenity_kindergarten"=>"childcare",
    "amenity_doctors"=>"doctor",
    "amenity_education"=>"education",
    "amenity_fast_food"=>"fastfood",
    "amenity_fuel"=>"fuel",
    "amenity_restaurant"=>"gastronomie",
    "amenity_atm"=>"geldautomat",
    "amenity_hospital"=>"hospital",
    "amenity_cinema"=>"kino",
    "amenity_parking"=>"parking",
    "amenity_police"=>"police",
    "amenity_restaurant"=>"restaurant",
    "amenity_theatre"=>"theater",
    "sport_bowling"=>"bowling"
  }  
end
