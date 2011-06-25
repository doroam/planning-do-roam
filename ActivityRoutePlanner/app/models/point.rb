class Point < ActiveRecord::Base
  belongs_to :route
  belongs_to :activity

  require 'uri'
  include Comparable
  include RouteHelper
  GLOBAL_FIELD_SOURCE                 = Global::GLOBAL_FIELD_SOURCE
  GLOBAL_FIELD_TARGET                 = Global::GLOBAL_FIELD_TARGET
  GLOBAL_ALIAS_END_POINT_LONG   = Global::GLOBAL_ALIAS_END_POINT_LONG
  GLOBAL_ALIAS_END_POINT_LAT    = Global::GLOBAL_ALIAS_END_POINT_LAT
  GLOBAL_ALIAS_START_POINT_LONG = Global::GLOBAL_ALIAS_START_POINT_LONG
  GLOBAL_ALIAS_START_POINT_LAT  = Global::GLOBAL_ALIAS_START_POINT_LAT

  attr_accessor :tag,
                :value



  def reset
    self.label = nil
    self.lat = nil
    self.lon = nil
    self.save
  end

  def is_setted
    return self.label!=nil && !"".eql?(self.label)
  end

  def set_edge
    edge = RouteHelper.get_nearest_edge(self)
    if(edge!=nil)
      self.edgeID = edge[GLOBAL_FIELD_SOURCE].to_i
      self.edgeTargetID = edge[GLOBAL_FIELD_TARGET].to_i
      self.edge_lat = edge[GLOBAL_ALIAS_START_POINT_LAT]
      self.edge_lon = edge[GLOBAL_ALIAS_START_POINT_LONG]
      self.edge_end_lat = edge[GLOBAL_ALIAS_END_POINT_LAT]
      self.edge_end_lon = edge[GLOBAL_ALIAS_END_POINT_LONG]
    end
  end

  def set_coordinates(lat_st,long_st)
    num_lat = lat_st.to_f
    num_lat = num_lat
    num_lon = long_st.to_f
    num_lon = num_lon
    self.lat = num_lat
    self.lon = num_lon
  end

  #parses input coordinats to lat and long
  def parse_label
    
    results = self.label.split(":")
    
    if results.size == 2
      lat_st  = results[0]
      long_st = results[1]
      
      num_lat = lat_st.to_f
      num_lat = num_lat
      num_lon = long_st.to_f
      num_lon = num_lon
      self.lat = num_lat
      self.lon = num_lon

      self.label = num_lat.round(8).to_s+":"+num_lon.round(8).to_s
      self.save
    end
    @distance_source = 0.0
    @distance_target = 0.0
  end

  #comparator for points
  #heuristic comparator for the best route of the acitvities
  #based on the air distance from start to point
  def <=> (o)

    point1 = self
    point2 = o

    #compare distance to source
    result_src = 1
    if point1.distance_source < point2.distance_source
      result_src = -1
    end
    return result_src    
    
  end
  #return the encoded label for javascript messages
  def label_js
    return self.label.gsub(/'/, "\\\\'")
  end
end