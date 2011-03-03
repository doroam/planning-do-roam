class Route 
  #contains the main information of the application
  GLOBAL_FIELD_NAME     = Global::GLOBAL_FIELD_NAME
  GLOBAL_FIELD_LONG     = Global::GLOBAL_FIELD_LONG
  GLOBAL_FIELD_LAT      = Global::GLOBAL_FIELD_LAT
  GLOBAL_TABLE_POINT    = Global::GLOBAL_TABLE_POINT
  GLOBAL_TABLE_POLYGON  = Global::GLOBAL_TABLE_POLYGON
  GLOBAL_FIELD_AMENITY  = Global::GLOBAL_FIELD_AMENITY


  attr_accessor :start_point,#start point of the route
    :end_point,#end point of the route
    :activities,#activities
    :algorithmus,#algorithmus to calculate the route
    :sort,#flag to sort the activities
    :kml_path#path to the kml file to show the route

  #initializes a route
  def initialize
    @start_point = Point.new
    @end_point = Point.new
    @algorithmus = "A*"
    @sort = "false"
  end
  #resets a route
  def reset
    @activities = nil
    @kml_path = ""
  end
  #Creates javascript code to show the Marks of the selected route
  def show_markers()
    script = ""
    #adds start mark
    if @start_point != nil && @start_point.label!=nil && !@start_point.label.eql?("")
      script = "addMark('"+@start_point.label_js+"','"+@start_point.lat+"','"+@start_point.long+"','start');"
    end
    #adds end mark
    if @end_point != nil && @end_point.label != nil && !@end_point.label.eql?("")
      script += "addMark('"+@end_point.label_js+"','"+@end_point.lat+"','"+@end_point.long+"','end');"
    end
    #adds activities mark
    if @activities != nil
      @activities.each.with_index do |activity,id|
        if activity.result != nil
          imagePath = activity.get_image_url()
          imageID   = activity.get_image_id()
          result    = activity.result
                script += "addActivityMark('"+result.label_js+"','"+result.lat+"','"+result.long+"','"+imagePath+"','"+imageID+"');"
        end
      end
    end
    #adds the route if there is one
    if @kml_path != nil && !@kml_path.eql?("")
      script += "loadRoute('"+@kml_path+"');"
    end
    return script
  end    

  #gets the closest point to start and endpoint where the activity can be done
  def self.get_closest_activity(activity,pstart,pend)
    #head of the sql query for the point table
    sql_head_point    = "select "+GLOBAL_FIELD_NAME+","+GLOBAL_FIELD_LONG+","+GLOBAL_FIELD_LAT+","+get_distance_query(pstart,pend)+" from "+GLOBAL_TABLE_POINT
    #head of the sql query for the polygon table
    sql_head_polygon  = "select "+GLOBAL_FIELD_NAME+","+GLOBAL_FIELD_LONG+","+GLOBAL_FIELD_LAT+","+get_distance_query(pstart,pend)+" from "+GLOBAL_TABLE_POLYGON
    #sort the results and gets the closest one
    limit   = " order by distance limit 1;"
    #gets the desired activity
    where   = " where "+activity.tag+" = '"+activity.value+"' "
    #unites the results of the point table and the polygon table
    sql     = "("+sql_head_point+where+" union "+sql_head_polygon+where+") "+limit
    result  = execute_sql(sql)
    activity.result = result
  end

  def sort
    return @sort
  end
  
  def algortihmus
    return @algorithmus
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
    ActiveRecord::Base.establish_connection(:osm_data)
    res = ActiveRecord::Base.connection.execute(sql)
    res = get_sql_results(res)
    return res
  end


  #creates points from the results of a sql query if there are some
  def self.get_sql_results(res)
    if res.num_tuples >0
      row = res[0]
      if row!= nil
        point = make_point(row)
      end
      return point
    else
      return nil
    end  
  end


  #creates a point from a result of the database
  def self.make_point(row)
    #fields for the point
    name  = row["name"]
    lat   = row["y"]
    lon   = row["x"]
    #distance to route's start point
    #distance to route's end point
    d_source = row["dist_source"]
    d_target = row["dist_target"]

    #if no name available
    if name ==nil
      name = "no name found"
    end
    #set information
    if lat != nil && lon != nil
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