# To change this template, choose Tools | Templates
# and open the template in the editor.

class RouteGenerator
  ActiveRecord::Base.establish_connection(:road_data)
  def initialize
    
  end
  def self.generate_route(route)
    source = get_nearest_edge(route.start_point)
    target = get_nearest_edge(route.end_point)
    result = get_shortest_path(source["source"],target["target"]);
    #result.push(source["source"])
    #result.push(target["target"])
    return result
  end
  def self.get_nearest_edge(point)
    sql = "SELECT name,highway,gid, source, target, the_geom,distance(the_geom, GeometryFromText('POINT("+point.long+" "+point.lat+")', 4326)) AS dist FROM ways"
	  lat_max   = (point.lat.to_d+0.1).to_s
    long_max  = (point.long.to_d+0.1).to_s
    lat_min   = (point.lat.to_d-0.1).to_s
    long_min  = (point.long.to_d-0.1).to_s
    #sql = "SELECT source,distance(GeomFromText('POINT("+point.lat+" "+point.long+")',4326),st_transform(the_geom,4326))  FROM ways"
    where = " WHERE highway = 'primary' and (the_geom && setsrid('BOX3D("+long_min+" "+lat_min+","+long_max+" "+lat_max+")'::box3d, 4326) )ORDER BY dist LIMIT 1;"
    return get_edge(sql+where)
  end
  private
  def self.generate_simple_route(source,target)
    source_id = get_nearest_vertice(start)
    target_id = get_nearest_vertice(end_point)
    result = get_shortest_path(source_id,target_id)
    return result
  end
  def self.get_shortest_path(source,target)    
    sql = "SELECT rt.gid, asKML(rt.the_geom) AS geojson,length(rt.the_geom) AS length, ways.gid FROM ways,"
	  where = " (SELECT gid, the_geom FROM dijkstra_sp_delta('ways',"+source+","+target+",0.1)) as rt WHERE ways.gid=rt.gid;"
    return get_path(sql+where)
  end

  def self.get_nearest_vertice(point)
    sql = "SELECT source,distance(GeomFromText('POINT("+point.lat+" "+point.long+")',4326),st_transform(the_geom,4326))  FROM ways"
    where = " where highway='primary' order by distance limit 1;"
    return get_id(sql+where)
  end

  def self.get_edge(sql)
    res = ActiveRecord::Base.connection.execute(sql)
    row = res[0]
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
