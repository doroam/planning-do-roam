class ActivityController < ApplicationController
  
  #method is called on a action of each 
  #activity
  def update_activity
    @route = current_route
    if params[:delete_activity]
      index = params[:delete_activity].to_i
      activity = Activity.find(index)      
      activity.destroy
    end    
      
    respond_to do |format|      
      format.js
    end
  end

  #creates an acitivity
  def create
    @route = current_route
    @activity = Activity.new(params[:activity])
        
    #create activity
    @activity.route = @route
    @activity.save

    #create point
    @point       = Point.new(params[:point])
    #get distance to start
    #@point.distance_source = RouteHelper.get_distance(current_route.start_point, @point)
    @point.activity = @activity
    #set nearest edge to activity
    #@point.set_edge
    @point.save

    respond_to do |format|
      format.js
    end
  end

  def search
    start_point = current_route.start_point   #to calculate distance
    @result = ""

    if !params[:reload].nil? && params[:reload]
      #get activity->getclasses
      classes = session[:current_classes]
      interval = session[:current_interval]
    else
      classes = if params[:class].nil? then [] else params[:class].keys end
      session[:current_classes] = classes
      if !params[:time].nil? then
        start = params[:day].to_i * Interval::DAY + params[:hour].to_i * 60 + params[:min].to_i * 10
        stop = start + params[:duration_hour].to_i * 60 + params[:duration_min].to_i * 10
        @result += "\n:::"+start.to_s+"   "+stop.to_s
        interval = Interval.new(:start => start, :stop => stop)
        @result += "\n:::"+interval.to_s
      end
      
      session[:current_interval] = interval
    end
      
    @result += classes.to_s+"<br/>"
    @points = Array.new
    
    # begin of loop
    classes.each do |cid|
      c = OntologyClass.find_by_id(cid.to_i)
      @result += c.name+"<br/>"
      
      minlon = params[:minlon].to_f
      minlat = params[:minlat].to_f
      maxlon = params[:maxlon].to_f
      maxlat = params[:maxlat].to_f

      min_lon, min_lat, max_lon, max_lat = sanitise_boundaries([minlon,minlat, maxlon, maxlat])
      # check boundary is sane and area within defined
      begin
        check_boundaries(min_lon, min_lat, max_lon, max_lat)
      rescue Exception => err
        # TODO senceless rescue!
        @result += ":::::::"+err.to_s
        return
      end
      
      area = OSM.sql_for_area(minlat, minlon, maxlat, maxlon,"current_nodes.")
      
      # get all the points
      om = OntologyMapping.find_by_name("activities2tags")
      for sub in c.descendants.select{|x| x.safe_iconfile!="question-mark.png"} # .select{|x| x.interesting(om)}
        search = om.nodetags_search(sub) # different queries
        if !search.nil?
          field_name = search.first[0]
          val = search.first[1]
          #nts = NodeTag.find(:all, :conditions => "(\"current_node_tags\".\"#{field_name}\" = '#{val}') AND " + area,:include=>"node")
          nts = NodeTag.find(:all, :joins => "INNER JOIN \"current_nodes_with_tags_mv\" ON \"current_nodes_with_tags_mv\".\"id\" = current_node_tags.node_id ", :conditions => "(\"current_nodes_with_tags_mv\".\"#{field_name}\" LIKE '#{val}') AND (\"current_nodes_with_tags_mv\".latitude BETWEEN #{(minlat * 10000000).round} AND #{(maxlat * 10000000).round}) AND (\"current_nodes_with_tags_mv\".longitude BETWEEN #{(minlon * 10000000).round} AND #{(maxlon * 10000000).round})")
          # nts = ActiveRecord::Base.connection.execute("SELECT id FROM current_nodes_with_tags_mv WHERE #{field_name} = '#{val}' AND (latitude BETWEEN #{(minlat * 10000000).round} AND #{(maxlat * 10000000).round}) AND (longitude BETWEEN #{(minlon * 10000000).round} AND #{(maxlon * 10000000).round});")
          if !interval.nil? then
            # TODO: optimise this using database queries, similar to those (but be aware of duplicate use to NodeTag that is needed):
            # Interval.find(:all,:conditions => ["start <=  ? and stop >= ?",start,stop])
            # positions = Positions.find :all, :conditions => ['id in (?)', nts.map(&:id)]
            @result += "\nresults:::"+nts.size.to_s
            nts = nts.select{
              |nt|
              if nt.intervals.size>0
                @result += "\nintervals:::"+nt.intervals.size.to_s
              end
              
              interval.dsfe_many(nt.intervals)

              }
            @result += "\nresultsafter:::"+nts.size.to_s
          end
          for nt in nts
            lat = nt.node.lat.to_s
            lon = nt.node.lon.to_s
            name = nt.node.tags["name"]
            icon = sub.safe_iconfile
            opening_hours_tag = nt.node.tags["opening_hours"]
            opening_hours = if opening_hours_tag.nil? then "" else opening_hours_tag.gsub(/;/,"<br />") end
            @result += "opening="+opening_hours
            point = make_point(name, icon, lat, lon, start_point)
            @points.push(point)
          end
        end
      end
    end
    #end of loop
    respond_to do |format|
      format.js
    end
  end

  def make_point(name,icon,lat,lon,start_point)
    point       = Point.new
    point.label = name
    point.set_coordinates(lat,lon)
    point.distance_source = RouteHelper.get_distance(start_point, point)
    if icon == nil
      icon = ""
    end
    point.icon = Global::IMAGE_URL_PREFIX+icon
    return point
  end

  MAX_REQUEST_AREA = 25
  # Take an array of length 4, and return the min_lon, min_lat, max_lon and
  # max_lat within their respective boundaries.
  def sanitise_boundaries(bbox)
    min_lon = [[bbox[0].to_f,-180].max,180].min
    min_lat = [[bbox[1].to_f,-90].max,90].min
    max_lon = [[bbox[2].to_f,+180].min,-180].max
    max_lat = [[bbox[3].to_f,+90].min,-90].max
    return min_lon, min_lat, max_lon, max_lat
  end

  def check_boundaries(min_lon, min_lat, max_lon, max_lat)
    # check the bbox is sane
    unless min_lon <= max_lon
      raise "The minimum longitude must be less than the maximum longitude, but it wasn't"
    end
    unless min_lat <= max_lat
      raise "The minimum latitude must be less than the maximum latitude, but it wasn't"
    end
    unless min_lon >= -180 && min_lat >= -90 && max_lon <= 180 && max_lat <= 90
      # Due to sanitize_boundaries, it is highly unlikely we'll actually get here
      raise "The latitudes must be between -90 and 90, and longitudes between -180 and 180"
    end

    # check the bbox isn't too large
    requested_area = (max_lat-min_lat)*(max_lon-min_lon)
    if requested_area > MAX_REQUEST_AREA
      raise "The maximum bbox size is " + MAX_REQUEST_AREA.to_s +
        ", and your request was too large. Either request a smaller area, or use planet.osm"+
        "size="+requested_area.to_s
    end
  end
  
  def list
    @day = Date.today.wday-1
    @hour = Time.now.hour
    @min = Time.now.min
    render :partial => "list"
  end

end