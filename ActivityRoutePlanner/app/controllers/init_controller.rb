class InitController < ApplicationController

  def index  
    @route = current_route
    #algorythm choices
    @alg_list = Array.new
    @alg_list.push Selection.new("OSRM","osrm")
    @alg_list.push Selection.new("YOURS","yours")
#   @alg_list.push Selection.new("fast","A*") Not supportet at the moment
#   @alg_list.push Selection.new("exact","Dijkstra") Not supportet at the moment
#    @alg_list.push Selection.new("energy","energy") 
    
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

  
end