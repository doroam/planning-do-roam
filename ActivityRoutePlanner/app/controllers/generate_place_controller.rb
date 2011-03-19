class GeneratePlaceController < ApplicationController
  
  #controller is called on each activity action
  def update_place
    @route = Route.find(session[:main_route])

    #start point was set
    if params[:start]!=nil
      set_point(@route.start_point, params[:start])
      @route.reset()
    #destination point was set
    elsif params[:end]!=nil
      set_point(@route.end_point, params[:end])
      @route.reset()
    #delete a point  
    elsif params[:delete_point] != nil
      if params[:delete_point].eql? "start"
        remove_point(@route.start_point)
      elsif params[:delete_point].eql? "end"  
        remove_point(@route.end_point)
      end 
    end
 
    #activate or deactivate activities to choose
    activate_activities(@route)
    
    respond_to do |format|      
      format.js 
    end
  end
  #removes a point
  def remove_point(point)
    point.reset
    point.save
  end
  #sets a point with the entered label
  def set_point(point, label)
      point.label = label
      #parse the input if it is "lat;lon"
      #or searches the input in the db
      point.parse_label
      point.save()
      handle_error(point,label)
  end
  
  
  #If user has given an start- and endPoint, 
  #so activates activity-list if not done  
  def activate_activities(route)
    if route.start_point.is_setted && route.end_point.is_setted
           @activity = Activity.new()
           @activity.route = route
           @activity.save
    else #if labels of points are nil      
      route.activities.delete_all
    end   
  end

  #sets the algorithmus and sorting method to use
  def set_algorithmus       
    a     = params[:algo]
    route = Route.find(session[:main_route])
    sort  = params[:sort]
    
    if a != nil
      route.algorithmus = a
    elsif sort != nil
      route.sort = sort
    end
    route.save
    respond_to do |format|      
      format.js 
    end
  end

  #handles errors by parsing lables of a point
  def handle_error(point,label)
    if point.label == nil || point.label.eql?("")
      flash[:error_msg] = "The place "+label+" could not be found"
    else
      flash[:error_msg] = nil
    end
  end
end
