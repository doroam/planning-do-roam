# To change this template, choose Tools | Templates
# and open the template in the editor.

class GeoResult
  attr_accessor :nearest_start,:nearest_end,:kml_list,:errors
  def initialize (start_lat,start_lon,end_lat,end_lon,kml_list,errors)
    @nearest_start = Point.new
    @nearest_start.label = start_lat+";"+start_lon
    @nearest_start.parse_label
    @nearest_end = Point.new
    @nearest_end.label = end_lat+";"+end_lon
    @nearest_end.parse_label
    @kml_list = kml_list
    @errors = errors
  end

end
