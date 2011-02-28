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
  IMAGE_URL_PREFIX = ".png"  
  IMAGE_URLS = {
    "doctors"=>"aertze"
    
    }
  
end
