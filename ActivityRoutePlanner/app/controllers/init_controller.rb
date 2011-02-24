class InitController < ApplicationController
  helper_method :get_points_near_to
  def index
    route = Route.new
    route.start_point = Point.new
    route.end_point = Point.new
    session[:main_route] = route

    test = Route.get_points_near_to()

    @route = route
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml }
    end
  end


end
