class Point
  include Comparable
  attr_accessor :lat,:long,:label,:distance_source,:distance_target
  #constructor for label, lat and long
  def initialize(label,lat,long)
    @lat = lat
    @long = long
    @label = label
  end
  #default constructor
  def initialize
  end

  #parses input coordinats to lat and long
  def parse_label
    results = @label.split(";")
    if results.size > 1
      @lat  = results[0]
      @long = results[1]
      
      num_lat = @lat.to_f
      num_lat = num_lat.round(8)
      num_lon = @long.to_f
      num_lon = num_lon.round(8)      
      
      @label = num_lat.to_s+";"+num_lon.to_s
    else
      #search db
    end
    @distance_source = 0.0
    @distance_target = 0.0
  end
  def <=> (o)

    point1 = self
    point2 = o
    
    result_src = -1
    d_src = point2.distance_source
    p ":::::  1_src"+point1.distance_source.to_s+"2_src="+point2.distance_source.to_s
    if point1.distance_source < point2.distance_source
      d_src = point1.distance_source
      result_src = 1
    end
    
    
    p "::::: 1_target"+point1.distance_target.to_s+"2_target="+point2.distance_target.to_s
    result_target = -1
    d_target = point2.distance_target
    if point1.distance_target < point2.distance_target
      d_target = point1.distance_target
      result_target = 1
    end

    p ":::: src="+result_src.to_s+"   target="+result_target.to_s
    if result_src==1 && result_target==1
      return 1;
    elsif result_src==-1 && result_target==-1
      return -1
    else
      if d_src < d_target
        return result_src
      else
        return result_target
      end
    end
    
  end
end