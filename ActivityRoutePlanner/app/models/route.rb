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

    sql = "select "+global_field_name+","+global_field_long+","+global_field_lat+","+get_distance_query(pstart,pend)+" from "+global_table_point

    activities.each do |activity|
      where   = " where "+global_field_amenity+" = '"+activity.value+"' order by distance limit 3;"
      result  = execute_sql(sql+where)
      activity.result = result
    end
  end

  def self.get_closest_activity(activity,pstart,pend)
    global_field_name = "name"
    global_field_long = "X(transform(way,4326))"
    global_field_lat  = "Y(transform(way,4326))"
    global_table_point = "planet_osm_point"
    global_field_amenity = "amenity"
    sql     = "select "+global_field_name+","+global_field_long+","+global_field_lat+","+get_distance_query(pstart,pend)+" from "+global_table_point
    where   = " where "+global_field_amenity+" = '"+activity.value+"' order by distance limit 3;"
    result  = execute_sql(sql+where)
    activity.result = result
  end

  private
  def self.get_distance_query(pstart,pend)
    distance_p1 = "distance(GeomFromText('POINT("+pstart.lat+" "+pstart.long+")',4326),st_transform(way,4326))"
    distance_p2 = "distance(GeomFromText('POINT("+pend.lat+" "+pend.long+")',4326),st_transform(way,4326))"
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
