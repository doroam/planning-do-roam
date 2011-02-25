class InitController < ApplicationController
  helper_method :get_points_near_to
  def index
    if session[:main_route] == nil
      p "neu"
      route = Route.new
      route.start_point = Point.new
      route.end_point = Point.new

      activity_list = Array.new
      activity_list.push(Activity.new("amenity", "hospital"))
      activity_list.push(Activity.new("amenity", "bank"))
      activity_list.push(Activity.new("amenity", "police"))
      activity_list.push(Activity.new("amenity", "restaurant"))

      session[:main_activity_list] = activity_list
      session[:main_route] = route
    end
    @route = route
    respond_to do |format|
      format.html
      format.xml  { render :xml }
    end
  end

  def reset
    session[:main_route] = nil

    respond_to do |format|
        format.html { redirect_to( root_path) }
    end    
  end

end
