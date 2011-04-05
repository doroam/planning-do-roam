class Point < ActiveRecord::Base
  belongs_to :route
  belongs_to :activity

  require 'uri'
  include Comparable

  GLOBAL_FIELD_NAME     = Global::GLOBAL_FIELD_NAME
  GLOBAL_FIELD_LONG     = Global::GLOBAL_FIELD_LONG
  GLOBAL_FIELD_LAT      = Global::GLOBAL_FIELD_LAT
  GLOBAL_TABLE_POINT    = Global::GLOBAL_TABLE_POINT
  GLOBAL_TABLE_POLYGON  = Global::GLOBAL_TABLE_POLYGON
  GLOBAL_FIELD_AMENITY  = Global::GLOBAL_FIELD_AMENITY

  attr_accessor :icon,
                :tag,
                :value,
                :distance_source#not setted!



  def reset
    self.label = nil
    self.lat = nil
    self.lon = nil
    self.save
  end

  def is_setted
    return self.label!=nil && !"".eql?(self.label)
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