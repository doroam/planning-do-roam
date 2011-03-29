class OntologySearchController < ApplicationController
  
  def ontosearch

    if !params[:reload].nil? && params[:reload]
      #get activity->getclasses
      classes = session[:current_classes]
    else
      classes = if params[:class].nil? then [] else params[:class].keys end
      session[:current_classes] = classes
    end
      
    @result = classes.to_s+"<br/>"
    @points = Array.new
    cids = classes
    om = OntologyMapping.find_by_name("activities2tags")

    cids.each do |cid|
      c = OntologyClass.find_by_id(cid.to_i)
      @result += c.name+"<br/>"
      start = params[:start]
      stop = params[:stop]
      minlon = params[:minlon].to_f
      minlat = params[:minlat].to_f
      maxlon = params[:maxlon].to_f
      maxlat = params[:maxlat].to_f

      min_lon, min_lat, max_lon, max_lat = sanitise_boundaries([minlon,minlat, maxlon, maxlat])
      # check boundary is sane and area within defined
      # see /config/application.yml
      begin
        check_boundaries(min_lon, min_lat, max_lon, max_lat)
      rescue Exception => err
        @result += ":::::::"+err.to_s
        return
      end

      # get all the points
      
      for sub in c.descendants.select{|x| x.safe_iconfile!="question-mark.png"} # .select{|x| x.interesting(om)}
        search = om.nodetags_search(sub) # different queries
        if !search.nil?
          val = search.first[1]
          
          #map key to tag value
          sql = "select k from current_node_tags where v='"+val.to_s+"' limit 1"
          res = ActiveRecord::Base.connection.execute(sql)
          if res.num_tuples>0
            tag = res[0]["k"]
            #@result += "tag="+tag+"   val="+val.to_s+"<br/>"
            begin
              sql = "select name,X(transform(way,4326)),Y(transform(way,4326)) from planet_osm_point where \""+tag+"\" = '"+val.to_s+"'"+
                " and Y(transform(way,4326)) BETWEEN "+minlat.to_s+" AND "+maxlat.to_s+" AND X(transform(way,4326)) BETWEEN "+minlon.to_s+" AND "+maxlon.to_s
              res = ActiveRecord::Base.connection.execute(sql)
              res.each do |result|
                name  = result["name"]
                lat   = result["y"]
                lon   = result["x"]
                point       = Point.new
                point.label = name
                point.tag = tag
                point.value = val.to_s
                point.set_coordinates(lat,lon)                
                icon      = Global::IMAGE_URLS[tag+"$"+val.to_s]
                if icon == nil
                    icon = ""
                else
                  icon_path = Global::IMAGE_URL_PREFIX
                  icon_type = Global::IMAGE_URL_SUFFIX
                  icon = icon_path+icon+icon_type
                end
                point.icon = icon
                @points.push(point)
              end

            rescue Exception => err
              @result += "The activity "+val.to_s+" could not be found in our database. It will be fixed soon! <br/>"
            end
          else
            @result += "no tag for "+val.to_s+"<br/>"
          end
        end
      end
    end
    respond_to do |format|
      format.js
    end
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
end
