# To change this template, choose Tools | Templates
# and open the template in the editor.

class Global < Enumeration
  self.add_value(:global_field_name, 'name')
  self.add_value(:global_field_amenity, 'amenity')
  self.add_value(:global_table_point, 'planet_osm_point')
  self.add_value(:global_field_long, 'X(transform(way,4326))')
  self.add_value(:global_field_lat, 'Y(transform(way,4326))')
end
