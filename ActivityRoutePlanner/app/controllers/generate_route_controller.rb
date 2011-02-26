class GenerateRouteController < ApplicationController
  
  def updateRoute
    route = session[:main_route]
           
    if params[:start]!=nil
      route = setStartPoint(route, params[:start])
    elsif params[:end]!=nil
      route = setEndPoint(route, params[:end])
    elsif params[:delete_point] != nil
      if params[:delete_point].eql? "start"
        route = removeStartPoint(route)
      elsif params[:delete_point].eql? "end"  
        route = removeEndPoint(route)   
      end 
    end
 
    route = activateOrDeactivateActivities(route) 

    session[:main_route] = route
    
    respond_to do |format|      
      format.js 
    end
  end
  
  def removeStartPoint(route)
    route.start_point = Point.new
    return route
  end
  
  def removeEndPoint(route)
    route.end_point = Point.new
    return route
  end
  
  def setStartPoint(route, label)
      route.start_point.label = label
      route.start_point.parse_label      
      return route
  end
  
  def setEndPoint(route, label)
      route.end_point.label = label
      route.end_point.parse_label
      return route
  end
  
  def activateOrDeactivateActivities(route)
    #If user has given an start- and endPoint, 
    #so activates activity-list if not done
    if (route.start_point.label != nil) && (route.end_point.label != nil)
      if (!route.start_point.label.eql? "") && (!route.end_point.label.eql? "")
        if route.activities == nil
           route.activities = Array.new
           route.activities.push(Activity.new("", ""))
        end
      else
        route.activities = nil
      end     
    else
      route.activities = nil
    end
    
    return route
  end
end