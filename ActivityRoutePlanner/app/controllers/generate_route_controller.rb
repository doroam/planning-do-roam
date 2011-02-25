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
    
    #If user has given an start- and endPoint, 
    #so activates activity-list if not done
    if (route.start_point.label != nil) && (route.end_point.label != nil)
      if (!route.start_point.label.eql? "") && (!route.end_point.label.eql? "")
        if route.activities == nil
           route.activities = Array.new
           route.activities.push(Activity.new("", ""))
        end   
      end       
    end

    session[:main_route] = route
    
    respond_to do |format|      
      format.js 
    end
  end
end