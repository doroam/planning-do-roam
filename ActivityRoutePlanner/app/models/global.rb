# To change this template, choose Tools | Templates
# and open the template in the editor.

class Global < ActiveRecord::Base 
  GLOBAL_FIELD_NAME = 'name'
  GLOBAL_FIELD_AMENITY = 'amenity'
  GLOBAL_TABLE_POINT = 'planet_osm_point'
  GLOBAL_FIELD_LONG = 'X(transform(way,4326))'
  GLOBAL_FIELD_LAT =  'Y(transform(way,4326))'
end
