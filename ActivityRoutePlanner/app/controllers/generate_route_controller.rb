class GenerateRouteController < ApplicationController
  
  def create
    
  end
  
  def updateRoute
    route = session[:main_route]
        
    
    if params[:start_point] != nil      
      route.start_point = params[:start_point]
    elsif params[:end_point] != nil
      route.end_point = params[:end_point]
    end
    
    session[:main_route] = route

    #weiterleiten zur startseite
    respond_to do |format|
      format.html { render 'init/_form'}
      format.js 
    end
  end
end