class Point < ActiveRecord::Base
  belongs_to :route
  belongs_to :activity

  require 'cgi'
  include Comparable

  GLOBAL_FIELD_NAME     = Global::GLOBAL_FIELD_NAME
  GLOBAL_FIELD_LONG     = Global::GLOBAL_FIELD_LONG
  GLOBAL_FIELD_LAT      = Global::GLOBAL_FIELD_LAT
  GLOBAL_TABLE_POINT    = Global::GLOBAL_TABLE_POINT
  GLOBAL_TABLE_POLYGON  = Global::GLOBAL_TABLE_POLYGON
  GLOBAL_FIELD_AMENITY  = Global::GLOBAL_FIELD_AMENITY
  
    
  #constructor for label, lat and long
  def initialize(label,lat,long)
    super
    self.lat = lat
    self.lon = long
    self.label = label
  end

  def initialize
    super
  end


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
    results = self.label.split(";")
    if results.size ==2
      lat_st  = results[0]
      long_st = results[1]
      
      num_lat = lat_st.to_f
      num_lat = num_lat
      num_lon = long_st.to_f
      num_lon = num_lon
      self.lat = num_lat
      self.lon = num_lon

      self.label = num_lat.round(8).to_s+";"+num_lon.round(8).to_s
      self.save
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
    name              = self.label.downcase
    sql_head_point    = "select "+GLOBAL_FIELD_NAME+","+GLOBAL_FIELD_LONG+","+GLOBAL_FIELD_LAT+" from "+GLOBAL_TABLE_POINT
    sql_head_polygon  = "select "+GLOBAL_FIELD_NAME+","+GLOBAL_FIELD_LONG+","+GLOBAL_FIELD_LAT+" from "+GLOBAL_TABLE_POLYGON
    #gets 1 result with a name like the input
    limit   = " limit 1;"
    where   = " where lower("+GLOBAL_FIELD_NAME+") like '%"+name+"%' "
    #unites the results from polygon and point
    sql     = "("+sql_head_point+where+" union "+sql_head_polygon+where+") "+limit
    
    res = ActiveRecord::Base.connection.execute(sql)

    #if there are results
    if res.num_tuples>0
      row = res[0]
      name_db  = row["name"]
      lat_db   = row["y"]
      lon_db   = row["x"]
      
      self.label = name_db
      self.lat   = lat_db
      self.lon  = lon_db
    else
      self.label = nil
    end

    self.save

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
    return CGI.escape(self.label)
  end
end