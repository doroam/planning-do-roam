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

  def create
    route = Route.find(session[:main_route])
    @activity = Activity.new(params[:activity])
        
    @activity.route = route
    @activity.save

    @point       = Point.new(params[:point])
    @point.distance_source = RouteHelper.get_distance(route.start_point, @point)
    @point.activity = @activity
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