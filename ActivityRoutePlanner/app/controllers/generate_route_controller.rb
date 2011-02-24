class GenerateRouteController < ApplicationController
  
  def create
    
  end
  
  def updateRoute
    route = session[:main_route]
           
    if params[:start]!=nil
      route.start_point.label = params[:start]
    elsif params[:end]!=nil
      route.end_point.label = params[:end]
    end
    
    respond_to do |format|      
      format.js 
    end
  end
end