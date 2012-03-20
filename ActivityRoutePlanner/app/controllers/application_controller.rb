class ApplicationController < ActionController::Base
  protect_from_forgery
  
private 
  #get the current route of the session
  def current_route
    Route.find(session[:main_route])
  rescue ActiveRecord::RecordNotFound
    route = Route.create
    session[:main_route] = route.id
    route
  end
  
  def errormessage(message)
    @message = message
    respond_to do |format|
      format.js
    end
  end
end
