class InitController < ApplicationController

  def index  
    @route = current_route  
    #if the session is new
   # if session[:main_route] == nil
      # initialize route
      #@route = Route.create()      
     # session[:main_route] = @route.id
    #else
     # route_id = session[:main_route]
      #@route = Route.find(route_id)
    #end
    
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