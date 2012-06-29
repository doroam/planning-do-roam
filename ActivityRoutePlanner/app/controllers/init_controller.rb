class InitController < ApplicationController

  def index  
    @route = current_route
    #algorythm choices
    @alg_list = Array.new
    @alg_list.push Selection.new("OSRM","osrm")
    @alg_list.push Selection.new("YOURS","yours")
#   @alg_list.push Selection.new("fast","A*") Not supportet at the moment
#   @alg_list.push Selection.new("exact","Dijkstra") Not supportet at the moment
    @alg_list.push Selection.new("energy","energy") 
    
    #energy-optimization-options
    @optimization_list = Array.new
    @optimization_list.push Selection.new("energy","ENERGY")
    @optimization_list.push Selection.new("distance","DISTANCE")
    @optimization_list.push Selection.new("time","TIME")
    @car_type = Array.new
    @car_type.push Selection.new("STROMOS","STROMOS")
    @car_type.push Selection.new("Sam","Sam")
    @car_type.push Selection.new("Luis","Luis")
    @car_type.push Selection.new("SmartRoadster","SmartRoadster")
    @car_type.push Selection.new("MUTE","MUTE")
    @car_type.push Selection.new("Karabag Fiat 500E","Karabag Fiat 500E")
    
    respond_to do |format|
      format.html
      format.xml  { render :xml }
    end
  end

  #reset route and reload page
  def reset
    session[:main_route] = nil
    respond_to do |format|
        format.html { redirect_to( root_path) }
    end    
  end
  
  def freetext
    @query = params[:freetext]
    qterms = @query.split(',')
    act = qterms.at(0)
    if act.nil? then # empty string, let osm handle
      
    else
     w = Word.find_by_lemma(act.downcase)
     if w.nil? then # the word is not an activity, do standard search
       redirect_to  :controller => "geocoder", :action => "search"
       return
       #redirect_to your_controller_action_url :params => { :a => "value", :b => "value2" }
       #redirect_to "geocoder_controller" :params => { :action => "search" } and return
       #redirect_to {:action => "search", "/geocoder_controller.rb"} and return
       #redirect_to (:geocoder_search_path) and return
       #render :js => "search" and return
       link_to_remote "Search", :update => "div_id", 
         :url  => {:controller=>"geocoder_controller",:action=>"search"}, :method => :delete, 
         :html => { :class  => "divs" } 

     
     else
       wsyns = w.synonyms.map{|x| OntologyClass.find_by_name(x.lemma.capitalize)}
       wsyns.delete(nil)
      if wsyns == [] then # no class found, do standard search
      #  redirect_to  :controller => "geocoder", :action => "search" and return
	#redirect_to "geocoder_controller" :params => { :action => "search" } and return
	#redirect_to {:action => "search" , "/geocoder_controller.rb"} and return
	#redirect_to ("/app/controllers/geocoder_controller.rb") and return
	#redirect_to :controller => "geocoder", :action => "search" and return
	#render :js => "search" and return
	link_to_remote "Search", :update => "div_id", 
         :url  => {:controller=>"geocoder_controller",:action=>"search"}, :method => :delete, 
         :html => { :class  => "divs" } 
	#redirect_to :controller => "geocoder", :action => "search" 
	#return
	#render :js => "search" and return
     
      else
        #interval search here
        interv = qterms.at(1)
        @interval = Interval.new(:start => 0, :stop => 0)
        if not interv.nil? then
          # we have a term that might be an interval
          intlist = Interval.parse_one(interv)
        #  if intlist != [] then
            # we have some intervals, we need to set up parameters
            @interval = intlist
            qterms.delete_at(1)
         # end
        end
	#wo = Words::Wordnet.new
        #word = "bank"

	#@classes = wo.find(word)
        @classes = wsyns.uniq.map{|x| x.name}
        classes2 = wsyns.map{|x| x.id}
	qterms.delete_at(0)
        @query = qterms.to_s

	ac(classes2,intlist)
    
      end
     end
    end

   
    
    respond_to do |format|
        format.html 
    end
  end

  def ac(cls,inte)
  start_point = current_route.start_point
        @result = ""

        #classes = cls
 
    @result += cls.to_s+"<br/>"
    #@points = Array.new
    @points = Hash.new
puts @result
    # begin of loop
    cls.each do |cid|
      c = OntologyClass.find_by_id(cid)
      @result += c.name+"<br/>"
      #logger.debug("======================>" + @result)  
      
      
      #minlon = 8.7884897133291
      #minlat = 53.057703977907
      #maxlon = 8.8808435341298
      #maxlat = 53.084107472864
      minlon = params[:minlon].to_f
      minlat = params[:minlat].to_f
      maxlon = params[:maxlon].to_f
      maxlat = params[:maxlat].to_f

      logger.debug("======================>" + minlon.to_s + " " + minlat.to_s + " " + maxlon.to_s + " " + maxlat.to_s)  
      

      min_lon, min_lat, max_lon, max_lat = sanitise_boundaries([minlon,minlat, maxlon, maxlat])
      # check boundary is sane and area within defined
      begin
        check_boundaries(min_lon, min_lat, max_lon, max_lat)
      rescue Exception => err
        # TODO senceless rescue!
        @result += ":::::::"+err.to_s
        return
      end
      
      # get all the points
      om = OntologyMapping.find_by_name("activities2tags")
      for sub in c.descendants.select{|x| x.safe_iconfile!="question-mark.png"} # .select{|x| x.interesting(om)}
        search = om.nodetags_search(sub) # different queries
        if !search.nil?
          field_name = search.first[0]
          val = search.first[1]
          nts = NodeTag.find(:all,:conditions=>OSM.sql_for_area(minlat, minlon, maxlat, maxlon,"current_nodes.")+" AND (\"current_node_tags\".\"#{field_name}\" = '#{val}')",:include=>"node")
	  if not inte.nil?
          logger.debug("****************>+++++++" + @interval[0].to_s + " "+@interval[-1].to_s)  
	  if inte[0]!=nil and inte[-1]!=nil then
	    
   
            nts = nts.select{
              |nt|
              
              inte.any? do |h| 
	    logger.debug("****************>+++++++" + h[0].class.to_s)  
	          h.dsfe_many(nt.intervals)
	      end

              }
            #@result += "\nresultsafter:::"+nts.size.to_s
          end
	  end

          for nt in nts
            lat = nt.node.lat.to_s
            lon = nt.node.lon.to_s
            name = nt.node.tags["name"]
            icon = sub.safe_iconfile
	    opening_hours_tag = nt.node.tags["opening_hours"]
            opening_hours = if opening_hours_tag.nil? then "" else opening_hours_tag.gsub(/;/,"<br />") end
            point = make_point(name, icon, lat, lon, start_point)
	    
	      #@points.push(point)
	      v={ point => opening_hours }
	      @points.merge!(v)
          end
        end
      end
      
      
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
  
  

end
