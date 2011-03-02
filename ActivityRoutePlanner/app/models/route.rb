class Route 
  GLOBAL_FIELD_NAME     = Global::GLOBAL_FIELD_NAME
  GLOBAL_FIELD_LONG     = Global::GLOBAL_FIELD_LONG
  GLOBAL_FIELD_LAT      = Global::GLOBAL_FIELD_LAT
  GLOBAL_TABLE_POINT    = Global::GLOBAL_TABLE_POINT
  GLOBAL_TABLE_POLYGON  = Global::GLOBAL_TABLE_POLYGON
  GLOBAL_FIELD_AMENITY  = Global::GLOBAL_FIELD_AMENITY

  attr_accessor :start_point,:end_point,:activities,:algorithmus,:sort
  def initialize
    @start_point = Point.new
    @end_point = Point.new
    @algorithmus = "A*"
    @sort = "false"
  end
  
  #Creates javascript code to show the Marks of the selected route
  def show_markers()
    script = ""
    #adds start mark
    if @start_point != nil && @start_point.label!=nil
      script = "addMark('"+@start_point.label+"','"+@start_point.lat+"','"+@start_point.long+"','start');"
    end
    #adds end mark
    if @end_point != nil && @end_point.label
      script += "addMark('"+@end_point.label+"','"+@end_point.lat+"','"+@end_point.long+"','end');"
    end
    #adds activities mark
    if @activities != nil
      @activities.each.with_index do |activity,id|
        if activity.result != nil
          imagePath = activity.get_image_url()
          activity.result.each.with_index do |result, index|
                script += "addActivityMark('"+result.label+"','"+result.lat+"','"+result.long+"','"+imagePath+"','"+index.to_s+"','"+id.to_s+"');"
          end
        end
      end
    end
    return script
  end    

  #gets the 3 closest points to start and endpoint where the activity can be done
  def self.get_closest_activity(activity,pstart,pend)
    
    sql_head_point    = "select "+GLOBAL_FIELD_NAME+","+GLOBAL_FIELD_LONG+","+GLOBAL_FIELD_LAT+","+get_distance_query(pstart,pend)+" from "+GLOBAL_TABLE_POINT
    sql_head_polygon  = "select "+GLOBAL_FIELD_NAME+","+GLOBAL_FIELD_LONG+","+GLOBAL_FIELD_LAT+","+get_distance_query(pstart,pend)+" from "+GLOBAL_TABLE_POLYGON
    #order the results to get closest TODO limit 1!
    limit   = " order by distance limit 3;"
    where   = " where "+activity.tag+" = '"+activity.value+"' "
    sql     = "("+sql_head_point+where+" union "+sql_head_polygon+where+") "+limit
    result  = execute_sql(sql)
    activity.result = result
  end

  private
  #Gets the distance from the point to the start point and from the point to the endpoint
  #and adds them. So we can later sort this distance and find the nearest one
  #TODO: Get path distance, not airline distance
  def self.get_distance_query(pstart,pend)
    distance_p1 = "distance(GeomFromText('POINT("+pstart.long+" "+pstart.lat+")',4326),st_transform(way,4326)) "
    distance_p2 = "distance(GeomFromText('POINT("+pend.long+" "+pend.lat+")',4326),st_transform(way,4326)) "
    result      = distance_p1+" as dist_source,"+distance_p2+" as dist_target,("+distance_p1+"+"+distance_p2+")as distance"
    return result
  end


  # executes a sql query and gets the results
  def self.execute_sql(sql)
    #sql = "SELECT name,X(transform(way,4326)),Y(transform(way,4326))  FROM planet_osm_point where name like '%bremen%';"
    ActiveRecord::Base.establish_connection(:osm_data)
    res = ActiveRecord::Base.connection.execute(sql)
    res = get_sql_results(res)
    return res
  end


  #creates points from the results of a sql query
  def self.get_sql_results(res)
    result = Array.new
    res.each  do |row|      
      point = make_point(row)
      if point != nil
        result.push(point)
      end
    end
    return result
  end


  #creates a point from a result of the database
  def self.make_point(row)
    name  = row["name"]
    lat   = row["y"]
    lon   = row["x"]
    d_source = row["dist_source"]
    d_target = row["dist_target"]
    if name != nil && lat != nil && lon != nil
      point       = Point.new
      point.label = name
      point.lat   = lat
      point.long  = lon
      point.distance_source = d_source.to_f
      point.distance_target = d_target.to_f
      return point
    end
    return nil
  end
end