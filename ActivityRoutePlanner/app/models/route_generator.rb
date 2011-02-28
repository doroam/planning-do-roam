# To change this template, choose Tools | Templates
# and open the template in the editor.

class RouteGenerator
  TABLE = "ways"
  
  def initialize
    
  end
  def self.generate_route(route)
    ActiveRecord::Base.establish_connection(:osm_data)
    source = get_nearest_edge(route.start_point)
    target = get_nearest_edge(route.end_point)
    result = Array.new
    geo_result = nil
    if source!=nil && target!=nil
      edge_src    = source["source"]
      edge_target = target["target"]
      highway_src = source["highway"]
      highway_target = target["highway"]
      geo_result = GeoResult.new(source["start_lat"], source["start_long"], target["end_lat"], target["end_long"], result)
      p "::::::::src="+edge_src+"-"+highway_src+"   target="+edge_target+"-"+highway_target
      result = get_shortest_path(edge_src,edge_target);
      if result.size==0
        p "::::::::NO PATH FOUND"
      end
    else
      p ":::::::::::NO SOURCE AND TARGET FOUND!"
    end
    #result.push(source["source"])
    #result.push(target["target"])
    if geo_result==nil
      geo_result = GeoResult.new(nil,nil,nil,nil,nil)
    end
    geo_result.kml_list = result
    return geo_result
  end




  def self.get_nearest_edge(point)
    start_end_coordinates = Global::GLOBAL_FIELD_END_POINT_LONG+","+Global::GLOBAL_FIELD_END_POINT_LAT+","+Global::GLOBAL_FIELD_START_POINT_LONG+","+Global::GLOBAL_FIELD_START_POINT_LAT
      sql = "SELECT name,highway,gid, "+start_end_coordinates+", source, target, the_geom,distance(transform(the_geom,4326), GeometryFromText('POINT("+point.long+" "+point.lat+")', 4326)) AS dist FROM "+TABLE
	  lat_max   = (point.lat.to_d+0.1).to_s
    long_max  = (point.long.to_d+0.1).to_s
    lat_min   = (point.lat.to_d-0.1).to_s
    long_min  = (point.long.to_d-0.1).to_s
    #sql = "SELECT source,distance(GeomFromText('POINT("+point.lat+" "+point.long+")',4326),st_transform(the_geom,4326))  FROM ways"
    except_ways = "(highway='primary' or highway='secondary' or highway='motorway' or highway='trunk')"#"(highway != '' and highway!='cycleway' and highway!='pedestrian' and highway!='footway')"
    where = " WHERE "+except_ways+" and (transform(the_geom,4326) && setsrid('BOX3D("+long_min+" "+lat_min+","+long_max+" "+lat_max+")'::box3d, 4326) )ORDER BY dist LIMIT 1;"
    return get_edge(sql+where)
  end



  private
  #def self.generate_simple_route(source,target)
  #  source_id = get_nearest_vertice(start)
  #  target_id = get_nearest_vertice(end_point)
  #  result = get_shortest_path(source_id,target_id)
  #  return result
  #end



  def self.get_shortest_path(source,target)    
    sql = "SELECT rt.gid, asKML(rt.the_geom) AS geojson,length(rt.the_geom) AS length, "+TABLE+".gid FROM "+TABLE+","

    algorithm = "dijkstra_sp"
    algorithm = "astar_sp"
	  where = " (SELECT gid, the_geom FROM "+algorithm+"('"+TABLE+"',"+source+","+target+")) as rt WHERE "+TABLE+".gid=rt.gid;"
    return get_path(sql+where)
  end

  #def self.get_nearest_vertice(point)
  #  sql = "SELECT source,distance(GeomFromText('POINT("+point.lat+" "+point.long+")',4326),st_transform(the_geom,4326))  FROM "+TABLE
  #  where = " where highway='primary' order by distance limit 1;"
  #  return get_id(sql+where)
  #end

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
