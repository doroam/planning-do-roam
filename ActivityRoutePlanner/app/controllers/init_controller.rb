class InitController < ApplicationController
  helper_method :get_points_near_to
  def index
    route = Route.new
    route.start_point = Point.new
    route.end_point = Point.new
    
    route.activities = Array.new
    route.activities.push(Activity.new("", ""))
    
    activity_list = Array.new
    activity_list.push(Activity.new("amenity", "hospital"))
    activity_list.push(Activity.new("amenity", "bank"))

    session[:main_activity_list] = activity_list
    session[:main_route] = route

    @route = route
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml }
    end
  end


end
