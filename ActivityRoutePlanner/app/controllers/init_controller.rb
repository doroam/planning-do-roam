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

     
     else
       wsyns = w.synonyms.map{|x| OntologyClass.find_by_name(x.lemma.capitalize)}
       wsyns.delete(nil)
      if wsyns == [] then # no class found, do standard search
      #  redirect_to  :controller => "geocoder", :action => "search" and return
	#redirect_to "geocoder_controller" :params => { :action => "search" } and return
	#redirect_to {:action => "search" , "/geocoder_controller.rb"} and return
	#redirect_to ("/app/controllers/geocoder_controller.rb") and return
	redirect_to :controller => "geocoder", :action => "search" 
	return
	#render :js => "search" and return
     
      else
        #interval search here
        interv = qterms.at(1)
        @interval = Interval.new(:start => 0, :stop => 0)
        if not interv.nil? then
          # we have a term that might be an interval
          intlist = Interval.parse_one(interv)
          if intlist != [] then
            # we have some intervals, we need to set up parameters
            @interval = intlist.first.first
            qterms.delete_at(1)
          end
        end
        @classes = wsyns.uniq.map{|x| x.name.to_s}
        qterms.delete_at(0)
        @query = qterms.to_s
       
      end
     end
    end

   
    
    respond_to do |format|
        format.html 
    end
  end
  
end