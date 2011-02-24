class GenerateRouteController < ApplicationController
  
  def create
    
  end
  
  def updateRoute
    route = session[:main_route]
        
    
    if params[:start_point] != nil      
      route.start_point = params[:start_point]
    elsif params[:end_point] != nil
      route.end_point = params[:end_point]
    elsif params[:add_new_activity_select_box] != nil            
     
    end
    
    respond_to do |format|      
      format.js 
    end
  end
end
