class ActivityController < ApplicationController
  
  #method is called on a action of each 
  #activity
  def update_activity
    #route = Route.find(session[:main_route])

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
    route = Route.find(session[:main_route])
    @activity = Activity.new(params[:activity])
        
    #create activity
    @activity.route = route
    @activity.save

    #create point
    @point       = Point.new(params[:point])
    #get distance to start
    @point.distance_source = RouteHelper.get_distance(route.start_point, @point)
    @point.activity = @activity
    #set nearest edge to activity
    @point.set_edge
    @point.save

    respond_to do |format|
      format.js
    end
  end

  def move
    

    respond_to do |format|
      format.js
    end
  end


end