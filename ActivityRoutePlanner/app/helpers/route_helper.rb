module RouteHelper
  TABLE = "hb_topo"
  GLOBAL_FIELD_SOURCE                 = Global::GLOBAL_FIELD_SOURCE
  GLOBAL_FIELD_TARGET                 = Global::GLOBAL_FIELD_TARGET
  GLOBAL_FIELD_TYPE             = Global::GLOBAL_FIELD_TYPE
  GLOBAL_FIELD_END_POINT_LONG   = Global::GLOBAL_FIELD_END_POINT_LONG
  GLOBAL_FIELD_END_POINT_LAT    = Global::GLOBAL_FIELD_END_POINT_LAT
  GLOBAL_FIELD_START_POINT_LONG = Global::GLOBAL_FIELD_START_POINT_LONG
  GLOBAL_FIELD_START_POINT_LAT  = Global::GLOBAL_FIELD_START_POINT_LAT
  GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM = Global::GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM
  GLOBAL_FIELD_ROAD_GEOM        = Global::GLOBAL_FIELD_ROAD_GEOM

  #Generates a geometric result to show the path.
  #The result contains the coordinates of the start of the nearest edge to the
  #start point and the coordinates of the end of the nearest edge to the end point.
  #It has also a list with kml code describing the path through all the points
  #start-activities-end
  def self.generate_route(route)
    geo_result  = nil
    result      = Array.new
    errors      = Array.new

    #create node way
    result_way = route.activities.clone
    sort_activities = route.sort

    #get first (closest) activity form the 3 posibilities
    result_way = result_way.collect { |activity|  activity.result}

    #set last point
    if sort_activities.eql?("true")
      result_way = result_way.sort
    end
    result_way.push(route.end_point)

    #coordinates from the nearest source edge and nearest target edge
    start_lat = "0.0"
    start_lon = "0.0"
    end_lat   = "0.0"
    end_lon   = "0.0"
    src_point = route.start_point

    alg_select = route.algorithmus

    is_energy = alg_select.eql?("energy")


    result_way.each do |point|
      
      if !is_energy
        #get nearest edge to start and end point
        source = src_point.edgeID#get_nearest_edge(src_point)
        target = point.edgeTargetID#get_nearest_edge(point)

        #get coordinates of nearest edge to start and end points
        if src_point!=nil && src_point.label.eql?(route.start_point.label)
          start_lat = src_point.edge_lat
          start_lon = src_point.edge_lon
        end
        if point!= nil && point.label.eql?(route.end_point.label)
          end_lat   = point.edge_end_lat
          end_lon   = point.edge_end_lon
        end
      end

      if (source != nil && target !=nil) || is_energy
        if is_energy
          path = get_energy_nodes(route,src_point,point)
        else
          #add route from source to target to the kml list
          path = generate_simple_route(source,target,route)
        end


        if path.length>0
          if !is_energy
            #adds a line from the start point to the nearest source point of the edge
            line = get_kml_line(src_point.lat,src_point.lon, src_point.edge_lat,src_point.edge_lon)
            result.push(line)
            result.concat(path)
            #adds a line form the end point to the nearest end point of the edge
            line = get_kml_line(point.lat,point.lon, point.edge_end_lat,point.edge_end_lon)
            result.push(line)
          else
            result.concat(path)
          end
        else
          #error message if the path could not be found
          errors.push(src_point.label+"\nto\n"+point.label)
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


    #build result object
    geo_result = GeoResult.new(start_lat,start_lon , end_lat, end_lon, result,errors)
    if geo_result==nil
      geo_result = GeoResult.new(nil,nil,nil,nil,nil,nil)
    end

    geo_result.kml_list = result


    return geo_result
  end


  def self.get_distance(src,target)
    sql = "select distance(GeometryFromText('POINT("+src.lon.to_s+" "+src.lat.to_s+")', 4326), GeometryFromText('POINT("+target.lon.to_s+" "+target.lat.to_s+")', 4326)) as dist  FROM "+TABLE+" limit 1;"
    res = ActiveRecord::Base.connection.execute(sql)
    row = nil
    res.each do |result|
      row = result
      break
    end
    return row["dist"]
  end

  
  #Gets the nearest edge to a point
  def self.get_nearest_edge(point)
    #if nothing was found
    if point != nil
      #gets start and end point of the edge and
      start_end_coordinates = GLOBAL_FIELD_END_POINT_LONG+","+GLOBAL_FIELD_END_POINT_LAT+","+GLOBAL_FIELD_START_POINT_LONG+","+GLOBAL_FIELD_START_POINT_LAT
      sql = "SELECT name,type_name, "+start_end_coordinates+", "+GLOBAL_FIELD_SOURCE+", "+GLOBAL_FIELD_TARGET+", distance("+GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM+", GeometryFromText('POINT("+point.lon.to_s+" "+point.lat.to_s+")', 4326)) AS dist FROM "+TABLE
      #data for the bounding box around the point
      #performance!
      lat_max   = (point.lat+0.15).to_s
      long_max  = (point.lon+0.15).to_s
      lat_min   = (point.lat-0.15).to_s
      long_min  = (point.lon-0.15).to_s
      #sql = "SELECT source,distance(GeomFromText('POINT("+point.lat+" "+point.lon+")',4326),st_transform(the_geom,4326))  FROM ways"
      #except_ways = "true"#"(highway='primary' or highway='secondary' or highway='motorway' or highway='trunk')"#"(highway != '' and highway!='cycleway' and highway!='pedestrian' and highway!='footway')"
      where =  " WHERE "+GLOBAL_FIELD_TYPE+"!='pedestrian' "
      where += " and ("+GLOBAL_FIELD_TRANSFORMED_ROAD_GEOM+" && setsrid('BOX3D("+long_min+" "+lat_min+","+long_max+" "+lat_max+")'::box3d, 4326) )"
      where += " ORDER BY dist LIMIT 1;"
      #executes and parses the result as an edge
      return get_edge(sql+where)
    end
    return nil
  end

  private

  #generates a route between 2 points
  def self.generate_simple_route(source,target,route)
    result = Array.new

    if source!=nil && target!=nil
      edge_src    = source.to_s
      edge_target = target.to_s

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
    return result
  end

  #Gets the distance from the point to the start point and from the point to the endpoint
  #and adds them. So we can later sort this distance and find the nearest one
  #TODO: Get path distance, not airline distance
  def self.get_distance_query(pstart,pend)
    distance_p1 = "distance(GeomFromText('POINT("+pstart.lon.to_s+" "+pstart.lat.to_s+")',4326),st_transform(way,4326)) "
    distance_p2 = "distance(GeomFromText('POINT("+pend.lon.to_s+" "+pend.lat.to_s+")',4326),st_transform(way,4326)) "
    result      = distance_p1+" as dist_source,"+distance_p2+" as dist_target,("+distance_p1+"+"+distance_p2+")as distance"
    return result
  end


  # executes a sql query and gets the results
  def self.execute_sql(sql)
    #ActiveRecord::Base.establish_connection(:osm_data)
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
      point.set_coordinates(lat,lon)

      point.distance_source = d_source.to_f
      point.distance_target = d_target.to_f
      return point
    end
    return nil
  end

  def self.get_energy_nodes(route,start_point,end_point)

    nodes = Array.new

    url = "http://greennav.in.tum.de:8192/routing?wsdl"

    xml =
      "<routingRequest ID=\"test\">"+
      "<feature>routeCalculation</feature>"+
      "<startNode>"+
      "<geoCoords latitude=\"47.733333\" longitude=\"10.316667\"/>"+
      "</startNode>"+
      "<targetNode>"+
      "<geoCoords latitude=\"47.733433\" longitude=\"10.316567\"/>"+
      "</targetNode>"+
      "<vehicleType>STROMOS</vehicleType>"+
      "<batteryChargeAtStart>95</batteryChargeAtStart>"+
      "<resultType>geoCoords</resultType>"+
      "</routingRequest>"

    xml = "<?xml version=\"1.0\" ?>"+
      "<S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\">"+
      "<S:Body>"+
      "<ns2:createRoutingResponseXMLString xmlns:ns2=\"http://server.greennav.in.tum.de/\"><arg0>"+
        "&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;"+
        "&lt;routingRequest ID=&quot;11:32:56 STROMOS 234&quot;&gt;"+
        "&lt;feature&gt;"+"routeCalculation"+"&lt;/feature&gt;"+
        "&lt;startNode&gt;"+
        "&lt;geoCoords latitude=&quot;"+start_point.lat.to_s+"&quot; longitude=&quot;"+start_point.lon.to_s+"&quot;/&gt;"+
        "&lt;/startNode&gt;"+
        "&lt;targetNode&gt;"+
        "&lt;geoCoords latitude=&quot;"+end_point.lat.to_s+"&quot; longitude=&quot;"+end_point.lon.to_s+"&quot;/&gt;"+
        "&lt;/targetNode&gt;"+
        "&lt;vehicleType&gt;"+route.car_type+"&lt;/vehicleType&gt;"+
        "&lt;batteryChargeAtStart&gt;"+"95"+"&lt;/batteryChargeAtStart&gt;"+
        "&lt;optimization&gt;"+route.optimization+"&lt;/optimization&gt;"+
        "&lt;resultType&gt;"+"geoCoords"+"&lt;/resultType&gt;"+
        "&lt;/routingRequest&gt;"+
      "</arg0></ns2:createRoutingResponseXMLString></S:Body></S:Envelope>"

    @error = ""
    begin
      client = Savon::Client.new do
          wsdl.document = url
      end

      @actions = client.wsdl.soap_actions
      @res = client.request :wsdl,:create_routing_response_xml_string do |soap|
        soap.xml = xml
      end

      xml_string = @res.to_hash[:create_routing_response_xml_string_response][:return]
      coords = REXML::Document.new(xml_string)
      @result = "xml=="+coords.elements["routingResponse/nodes"].size.to_s
      geocoords = coords.elements["routingResponse/nodes"]
      start = geocoords[1]
      geocoords.remove[1]
      geocoords.each do |node|
        start_coord = start.elements["geoCoords"]
        end_coord = node.elements["geoCoords"]
        nodes.push(get_kml_line(start_coord.attributes["latitude"],start_coord.attributes["longitude"],end_coord.attributes["latitude"],end_coord.attributes["longitude"]))
        start = node
      end


    rescue Exception => err
      @error = err.to_s
      p "error="+err.to_s
    end

    return nodes

  end




end
