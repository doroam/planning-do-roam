class Point
  require 'cgi'
  include Comparable

  GLOBAL_FIELD_NAME     = Global::GLOBAL_FIELD_NAME
  GLOBAL_FIELD_LONG     = Global::GLOBAL_FIELD_LONG
  GLOBAL_FIELD_LAT      = Global::GLOBAL_FIELD_LAT
  GLOBAL_TABLE_POINT    = Global::GLOBAL_TABLE_POINT
  GLOBAL_TABLE_POLYGON  = Global::GLOBAL_TABLE_POLYGON
  GLOBAL_FIELD_AMENITY  = Global::GLOBAL_FIELD_AMENITY
  

  attr_accessor :lat,:long,:label,
    :distance_source,#attribute for activity point: distance to start point
    :distance_target#attribute for activity point: distance to end point
    
  #constructor for label, lat and long
  def initialize(label,lat,long)
    @lat = lat
    @long = long
    @label = label
  end
  #default constructor
  def initialize
  end

  def reset
    @label = ""
    @lat = nil
    @long = nil
  end

  #parses input coordinats to lat and long
  def parse_label
    results = @label.split(";")
    if results.size ==2
      @lat  = results[0]
      @long = results[1]
      
      num_lat = @lat.to_f
      num_lat = num_lat.round(8)
      num_lon = @long.to_f
      num_lon = num_lon.round(8)      
      
      @label = num_lat.to_s+";"+num_lon.to_s
    #gets the point from the database by name
    else
      get_point_by_name()
      if @label == nil
        @lat = nil
        @long = nil
      end
    end
    @distance_source = 0.0
    @distance_target = 0.0
  end

  #gets the a point from the database with the entered substring
  def get_point_by_name()
    #search point or polygon with the name
    name              = @label.downcase
    sql_head_point    = "select "+GLOBAL_FIELD_NAME+","+GLOBAL_FIELD_LONG+","+GLOBAL_FIELD_LAT+" from "+GLOBAL_TABLE_POINT
    sql_head_polygon  = "select "+GLOBAL_FIELD_NAME+","+GLOBAL_FIELD_LONG+","+GLOBAL_FIELD_LAT+" from "+GLOBAL_TABLE_POLYGON
    #gets 1 result with a name like the input
    limit   = " limit 1;"
    where   = " where lower("+GLOBAL_FIELD_NAME+") like '%"+name+"%' "
    #unites the results from polygon and point
    sql     = "("+sql_head_point+where+" union "+sql_head_polygon+where+") "+limit
    ActiveRecord::Base.establish_connection(:osm_data)
    res = ActiveRecord::Base.connection.execute(sql)

    #if there are results
    if res.num_tuples>0
      row = res[0]
      name_db  = row["name"]
      lat_db   = row["y"]
      lon_db   = row["x"]
      
      @label = name_db
      @lat   = lat_db
      @long  = lon_db
    else
      @label = nil
    end

  end

  #comparator for points
  #heuristic comparator for the best route of the acitvities
  #based on the air distance from start to point
  def <=> (o)

    point1 = self
    point2 = o

    #compare distance to source
    result_src = 1
    d_src = point2.distance_source    
    if point1.distance_source < point2.distance_source
      d_src = point1.distance_source
      result_src = -1
    end
    return result_src
    #compare distance to target
    result_target = 1
    d_target = point2.distance_target
    if point1.distance_target < point2.distance_target
      d_target = point1.distance_target
      result_target = -1
    end

    #if one point is more near to target and source
    if result_src==-1 && result_target==-1
      return -1;
    elsif result_src==1 && result_target==1
      return 1
    #otherwise the nearest point to source or target will be sent
    #to the begining or end of the list
    else
      if d_src < d_target
        return 1
      else
        return -1
      end
    end
    
  end
  #return the encoded label for javascript messages
  def label_js
    return CGI.escape(@label)
  end
end