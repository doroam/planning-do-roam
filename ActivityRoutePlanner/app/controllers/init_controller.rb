class InitController < ApplicationController
  def index
    route = Route.new
    session[:main_route] = route

    @route = route
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml }
    end
  end


end
