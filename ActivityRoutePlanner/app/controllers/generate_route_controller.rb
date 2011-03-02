class GenerateRouteController < ApplicationController
  
  #controller is called on each activity action
  def updateRoute
    route = session[:main_route]
    
    #start point was set
    if params[:start]!=nil
      route = setStartPoint(route, params[:start])
    #destination point was set
    elsif params[:end]!=nil
      route = setEndPoint(route, params[:end])
    #delete a point  
    elsif params[:delete_point] != nil
      if params[:delete_point].eql? "start"
        route = removeStartPoint(route)
      elsif params[:delete_point].eql? "end"  
        route = removeEndPoint(route)   
      end 
    end
 
    #activate or deactivate activities to choose
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
      route.activities = nil
      route.kml_path = ""
      return route
  end
  
  def setEndPoint(route, label)
      route.end_point.label = label
      route.end_point.parse_label
      route.activities = nil
      route.kml_path = ""
      return route
  end
  
  #If user has given an start- and endPoint, 
  #so activates activity-list if not done  
  def activateOrDeactivateActivities(route)
    if (route.start_point.label != nil) && (route.end_point.label != nil)
      if (!route.start_point.label.eql? "") && (!route.end_point.label.eql? "")
        if route.activities == nil
           route.activities = Array.new
           route.activities.push(Activity.new("", ""))
        end
      else #if labels of points are empty
        route.activities = nil
      end     
    else #if labels of points are nil
      route.activities = nil
    end
    
    return route
  end
  
  def set_algorithmus       
    a = params[:algo]
    route = session[:main_route]
    sort = params[:sort]
    
    if a != nil
      route.algorithmus = a
    elsif sort != nil
      route.sort = sort
    end
    
    session[:main_route] = route    
    respond_to do |format|      
      format.js 
    end
  end
end
