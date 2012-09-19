#class to store a route result
class GeoResult
  attr_accessor :nearest_start,#nearest vertice to start point
    :nearest_end,#nearest vertice to end point
    :kml_list,#list of paths in kml form
    :errors#error list
  def initialize (start_lat,start_lon,end_lat,end_lon,kml_list,errors)
    @nearest_start = Point.new
    @nearest_start.label = start_lat+":"+start_lon
    @nearest_start.parse_label
    @nearest_end = Point.new
    @nearest_end.label = end_lat+":"+end_lon
    @nearest_end.parse_label
    @kml_list = kml_list
    @errors = errors
  end

end
