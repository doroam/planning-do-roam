# To change this template, choose Tools | Templates
# and open the template in the editor.

class RouteGenerator
  TABLE = "hb_topo"
  GLOBAL_FIELD_TYPE             = Global::GLOBAL_FIELD_TYPE
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
    geo_result  = nil
    result      = Array.new
    errors      = Array.new
    
    #create node way
    result_way = route.activities.clone
    sort_activities = route.sort

    #result_way = result_way.sort

    #delete last empty activity (is always the new empty one)
    result_way.delete_at(result.length-1)
    
    #get first (closest) activity form the 3 posibilities
    result_way = result_way.collect { |activity|  activity.result}

    #set last point
    if sort_activities.eql?("true")
      result_way = result_way.sort
    end
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
      if src_point!=nil && src_point.label.eql?(route.start_point.label)
          source_start = source
        end
        if point!= nil && point.label.eql?(route.end_point.label)
          target_end = target
        end
      if source != nil && target !=nil
        #add route from source to target to the kml list
        path = generate_simple_route(source,target,route)
        if path.length>0
          #adds a line from the start point to the nearest source point of the edge
          line = get_kml_line(src_point.lat,src_point.long, source["start_lat"],source["start_long"])
          result.push(line)
          result.concat(path)
          #adds a line form the end point to the nearest end point of the edge
          line = get_kml_line(point.lat,point.long, target["end_lat"],target["end_long"])
          result.push(line)
        else
          #error message if the path could not be found
          errors.push(CGI.escape(src_point.label)+" to "+CGI.escape(point.label))
        end
      else
        p "no vertice found"
      end

      #if the point was not found
      #the source point is still the same
      if point != nil
        src_point = point
      end
    end


    #coordinates from the nearest source edge and nearest target edge
    start_lat = 0.0
    start_lon = 0.0
    end_lat   = 0.0
    end_lon   = 0.0
    if source_start != nil
      start_lat = source_start["start_lat"]
      start_lon = source_start["start_long"]
    end

    if target_end !=nil
      end_lat = target_end["end_lat"]
      end_lon = target_end["end_long"]
    end


    #build result object
    geo_result = GeoResult.new(start_lat,start_lon , end_lat, end_lon, result,errors)
    if geo_result==nil
      geo_result = GeoResult.new(nil,nil,nil,nil,nil,nil)
    end

    geo_result.kml_list = result

    
    return geo_result
  end

  private
  #Gets the nearest edge to a point
  def self.get_nearest_edge(point)
    #if nothing was found
    if point != nil
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
      where =  " WHERE "+GLOBAL_FIELD_TYPE+"!='pedestrian' "#"("+GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM+" && setsrid('BOX3D("+long_min+" "+lat_min+","+long_max+" "+lat_max+")'::box3d, 4326) )"
      where += " ORDER BY dist LIMIT 1;"
      #executes and parses the result as an edge
      return get_edge(sql+where)
    end
    return nil
  end


  #generates a route between 2 points
  def self.generate_simple_route(source,target,route)
    result = Array.new

    if source!=nil && target!=nil
      edge_src    = source["source"]
      edge_target = target["target"]
      highway_src = source["type_name"]
      highway_target = target["type_name"]
      p "::::::::src="+edge_src+"-"+highway_src+"   target="+edge_target+"-"+highway_target

      #get path from source to target
      result = get_shortest_path(edge_src,edge_target,route);
      if result.size==0
        p ":::::::::NO PATH FOUND"
      end
    else
      p ":::::::::::NO SOURCE AND TARGET FOUND!"
    end
    return result
  end


  #gets the path from source to target TODO select algorithm
  def self.get_shortest_path(source,target,route)
    sql       = "SELECT rt.gid, asKML(rt."+GLOBAL_FIELD_ROAD_GEOM+") AS geojson,length(rt."+GLOBAL_FIELD_ROAD_GEOM+") AS length, "+TABLE+".gid FROM "+TABLE+","
    
    algorithm = "astar_sp"
    alg_select = route.algorithmus
    if alg_select.eql?("Dijkstra")
      algorithm = "dijkstra_sp"
    end
    
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

  #creates a line in kml format between the given coordinates
  def self.get_kml_line(src_lat,src_lon,target_lat,target_lon)
    return "<LineString><coordinates>"+src_lon.to_s+","+src_lat.to_s+" "+target_lon.to_s+","+target_lat.to_s+"</coordinates></LineString>"
  end

end
