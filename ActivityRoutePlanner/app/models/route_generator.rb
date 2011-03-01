# To change this template, choose Tools | Templates
# and open the template in the editor.

class RouteGenerator
  TABLE = "hb_topo"
  GLOBAL_FIELD_END_POINT_LONG   = Global::GLOBAL_FIELD_END_POINT_LONG
  GLOBAL_FIELD_END_POINT_LAT    = Global::GLOBAL_FIELD_END_POINT_LAT
  GLOBAL_FIELD_START_POINT_LONG = Global::GLOBAL_FIELD_START_POINT_LONG
  GLOBAL_FIELD_START_POINT_LAT  = Global::GLOBAL_FIELD_START_POINT_LAT
  GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM = Global::GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM
  GLOBAL_FIELD_ROAD_GEOM        = Global::GLOBAL_FIELD_ROAD_GEOM
  def initialize
    
  end
  #Generates a geometric result to show the path.
  #The result contains the coordinates of the start of the nearest edge to the
  #start point and the coordinates of the end of the nearest edge to the end point.
  #It has also a list with kml code describing the path through all the points
  #start-activities-end
  def self.generate_route(route)
    ActiveRecord::Base.establish_connection(:osm_data)
    geo_result = nil
    result = Array.new
    
    #create node way
    result_way = route.activities.clone

    #delete last empty activity (is always the new empty one)
    result_way.delete_at(result.length-1)
    #get first (closest) activity form the 3 posibilities
    #TODO show just nearest
    result_way = result_way.collect { |activity|  activity.result[0]}
    #set last point
    result_way.push(route.end_point)

    #initlialize start point
    source_start  = nil
    target_end    = nil
    src_point = route.start_point
    
    result_way.each do |point|
      #get nearest edge to start and end point
      source = get_nearest_edge(src_point)
      target = get_nearest_edge(point)

      #get coordinates of nearest edge to start and end points
      if src_point.label.eql?(route.start_point.label)
        source_start = source
      end
      if point.label.eql?(route.end_point.label)
        target_end = target
      end

      #add route from source to target to the kml list
      result.concat(generate_simple_route(source,target))
      src_point = point
    end

    #build result object
    geo_result = GeoResult.new(source_start["start_lat"], source_start["start_long"], target_end["end_lat"], target_end["end_long"], result)

    if geo_result==nil
      geo_result = GeoResult.new(nil,nil,nil,nil,nil)
    end

    geo_result.kml_list = result

    
    return geo_result
  end

  private
  #Gets the nearest edge to a point
  def self.get_nearest_edge(point)
    #gets start and end point of the edge and
    start_end_coordinates = GLOBAL_FIELD_END_POINT_LONG+","+GLOBAL_FIELD_END_POINT_LAT+","+GLOBAL_FIELD_START_POINT_LONG+","+GLOBAL_FIELD_START_POINT_LAT
    sql = "SELECT name,type_name, "+start_end_coordinates+", source, target, distance("+GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM+", GeometryFromText('POINT("+point.long+" "+point.lat+")', 4326)) AS dist FROM "+TABLE
	  #data for the bounding box around the point
    #performance!
    lat_max   = (point.lat.to_d+0.1).to_s
    long_max  = (point.long.to_d+0.1).to_s
    lat_min   = (point.lat.to_d-0.1).to_s
    long_min  = (point.long.to_d-0.1).to_s
    #sql = "SELECT source,distance(GeomFromText('POINT("+point.lat+" "+point.long+")',4326),st_transform(the_geom,4326))  FROM ways"
    #except_ways = "true"#"(highway='primary' or highway='secondary' or highway='motorway' or highway='trunk')"#"(highway != '' and highway!='cycleway' and highway!='pedestrian' and highway!='footway')"
    where = " WHERE ("+GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM+" && setsrid('BOX3D("+long_min+" "+lat_min+","+long_max+" "+lat_max+")'::box3d, 4326) )ORDER BY dist LIMIT 1;"
    #executes and parses the result as an edge
    return get_edge(sql+where)
  end


  #generates a route between 2 points
  def self.generate_simple_route(source,target)
    result = Array.new

    if source!=nil && target!=nil
      edge_src    = source["source"]
      edge_target = target["target"]
      #highway_src = source["type_name"]
      #highway_target = target["type_name"]
      #p "::::::::src="+edge_src+"-"+highway_src+"   target="+edge_target+"-"+highway_target

      #get path from source to target
      result = get_shortest_path(edge_src,edge_target);
      if result.size==0
        p ":::::::::NO PATH FOUND"
      end
    else
      p ":::::::::::NO SOURCE AND TARGET FOUND!"
    end
    return result
  end


  #gets the path from source to target TODO select algorithm
  def self.get_shortest_path(source,target)    
    sql       = "SELECT rt.gid, asKML(rt."+GLOBAL_FIELD_ROAD_GEOM+") AS geojson,length(rt."+GLOBAL_FIELD_ROAD_GEOM+") AS length, "+TABLE+".gid FROM "+TABLE+","

    algorithm = "dijkstra_sp"
    algorithm = "astar_sp"
	  where     = " (SELECT gid, the_geom FROM "+algorithm+"('"+TABLE+"',"+source+","+target+")) as rt WHERE "+TABLE+".gid=rt.gid;"
    return get_path(sql+where)
  end


  #gets the first result
  def self.get_edge(sql)
    #ActiveRecord::Base.establish_connection(:road_data)
    res = ActiveRecord::Base.connection.execute(sql)
    row = nil
    res.each do |result|
      row = result
      break
    end
    return row
  end


  #gets the kml representation of the path
  def self.get_path(sql)    
    res = ActiveRecord::Base.connection.execute(sql)
    result = Array.new
    res.each  do |row|
      geo = row["geojson"]
      result.push(geo)
    end
    return result
  end
end
