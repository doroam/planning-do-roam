class GenerateRouteController < ApplicationController
  

  def updateRoute
    route = session[:main_route]
           
    if params[:start]!=nil
      route.start_point.label = params[:start]
      route.start_point.parse_label
    elsif params[:end]!=nil
      route.end_point.label = params[:end]
      route.end_point.parse_label
    end

    session[:main_route] = route
    
    respond_to do |format|      
      format.js 
    end
  end
end