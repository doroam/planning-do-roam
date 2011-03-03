class GeneratePlaceController < ApplicationController
  
  #controller is called on each activity action
  def update_place
    route = session[:main_route]
    
    #start point was set
    if params[:start]!=nil
      setPoint(route.start_point, params[:start])
      route.reset()
    #destination point was set
    elsif params[:end]!=nil
      setPoint(route.end_point, params[:end])
      route.reset()
    #delete a point  
    elsif params[:delete_point] != nil
      if params[:delete_point].eql? "start"
        removePoint(route.start_point)
      elsif params[:delete_point].eql? "end"  
        removePoint(route.end_point)
      end 
    end
 
    #activate or deactivate activities to choose
    activateOrDeactivateActivities(route) 
    
    respond_to do |format|      
      format.js 
    end
  end
  #removes a point
  def removePoint(point)
    point.reset
  end
  #sets a point with the entered label
  def setPoint(point, label)
      point.label = label
      #parse the input if it is "lat;lon"
      #or searches the input in the db
      point.parse_label
      handle_error(point,label)
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
  end

  #sets the algorithmus and sorting method to use
  def set_algorithmus       
    a     = params[:algo]
    route = session[:main_route]
    sort  = params[:sort]
    
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

  #handles errors by parsing lables of a point
  def handle_error(point,label)
    if point.label == nil || point.label.eql?("")
      flash[:error_msg] = "The place "+CGI.escape(label)+" could not be found"
    else
      flash[:error_msg] = nil
    end
  end
end
