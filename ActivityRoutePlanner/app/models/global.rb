# To change this template, choose Tools | Templates
# and open the template in the editor.

class Global < ActiveRecord::Base 
  GLOBAL_FIELD_NAME = 'name'
  GLOBAL_FIELD_AMENITY = 'amenity'
  GLOBAL_TABLE_POINT = 'planet_osm_point'
  GLOBAL_TABLE_POLYGON = 'planet_osm_polygon'
  GLOBAL_FIELD_LONG = 'X(st_centroid(transform(way,4326)))'
  GLOBAL_FIELD_LAT =  'Y(st_centroid(transform(way,4326)))'
end
