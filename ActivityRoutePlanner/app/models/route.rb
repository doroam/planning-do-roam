# To change this template, choose Tools | Templates
# and open the template in the editor.

class Route
  attr_accessor :start_point,:end_point,:activities
  def initialize
    
  end
  def self.get_closest_activities(route)
    pstart  = route.start_point
    pend    = route.end_point
    activities = route.activities
    global_field_name = Global::global_field_name
    global_field_long = Global::global_field_long
    global_field_lat  = Global::global_field_lat
    global_table_point = Global::global_table_point
    global_table_polygon = Global::global_table_polygon
    global_field_amenity = Global::global_field_amenity
    sqlHeadPoint    = "select "+global_field_name+","+global_field_long+","+global_field_lat+","+get_distance_query(pstart,pend)+" from "+global_table_point
    sqlHeadPolygon  = "select "+global_field_name+","+global_field_long+","+global_field_lat+","+get_distance_query(pstart,pend)+" from "+global_table_polygon

    activities.each do |activity|
      limit   = " order by distance limit 3;"
      where   = " where "+global_field_amenity+" = '"+activity.value+"' "
      sql = "("+sqlHeadPoint+where+" union "+sqlHeadPolygon+where+") "+limit
      result  = execute_sql(sql)
      activity.result = result
    end
  end

  def self.get_closest_activity(activity,pstart,pend)
    global_field_name = Global::GLOBAL_FIELD_NAME
    global_field_long = Global::GLOBAL_FIELD_LONG
    global_field_lat  = Global::GLOBAL_FIELD_LAT
    global_table_point = Global::GLOBAL_TABLE_POINT
    global_table_polygon = Global::GLOBAL_TABLE_POLYGON
    global_field_amenity = Global::GLOBAL_FIELD_AMENITY
    sql_head_point    = "select "+global_field_name+","+global_field_long+","+global_field_lat+","+get_distance_query(pstart,pend)+" from "+global_table_point
    sql_head_polygon  = "select "+global_field_name+","+global_field_long+","+global_field_lat+","+get_distance_query(pstart,pend)+" from "+global_table_polygon
    limit   = " order by distance limit 3;"
    where   = " where "+global_field_amenity+" = '"+activity.value+"' "
    sql     = "("+sql_head_point+where+" union "+sql_head_polygon+where+") "+limit
    result = execute_sql(sql)
    activity.result = result
  end

  private
  def self.get_distance_query(pstart,pend)
    distance_p1 = "distance(GeomFromText('POINT("+pstart.long+" "+pstart.lat+")',4326),st_transform(way,4326))"
    distance_p2 = "distance(GeomFromText('POINT("+pend.long+" "+pend.lat+")',4326),st_transform(way,4326))"
    result      = "("+distance_p1+"+"+distance_p2+")as distance"
    return result
  end
  def self.execute_sql(sql)
    #sql = "SELECT name,X(transform(way,4326)),Y(transform(way,4326))  FROM planet_osm_point where name like '%bremen%';"
    ActiveRecord::Base.establish_connection(:osm_data)
    res = ActiveRecord::Base.connection.execute(sql)
    res = get_sql_results(res)
    return res
  end
  def self.get_sql_results(res)
    result = Array.new
    res.each  do |row|
      
      point = make_point(row)
      result.push(point)
    end
    return result
  end
  def self.make_point(row)
    name  = row["name"]
    lat   = row["y"]
    lon   = row["x"]
    
    point       = Point.new
    point.label = name
    point.lat   = lat
    point.long  = lon
    return point
  end
end
