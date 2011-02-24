class InitController < ApplicationController
  def index
    route = Route.new
    route.start_point = Point.new
    route.end_point = Point.new
    session[:main_route] = route

    

    @route = route
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml }
    end
  end


end
