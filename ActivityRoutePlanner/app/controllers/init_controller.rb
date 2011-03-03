class InitController < ApplicationController
  helper_method :get_points_near_to
  def index
    #if the session is new
    if session[:main_route] == nil
      initialize route
      route = Route.new      
   
      session[:main_route] = route
    end
    @route = route
    respond_to do |format|
      format.html
      format.xml  { render :xml }
    end
  end

  #reset route an reload page
  def reset
    session[:main_route] = nil
    respond_to do |format|
        format.html { redirect_to( root_path) }
    end    
  end
end