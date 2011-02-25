class ActivityController < ApplicationController
  
  def updateActivity
  
    if params[:activity]
      addActivity
    elsif params[:deleteActivity]
      deleteActivity    
    end
      
     respond_to do |format|      
     format.js
    end
  end
  
  def deleteActivity
    index = params[:deleteActivity]
    route = session[:main_route]
     
    p route.activities.length
    
    
    route.activities.delete_at index.to_i
    
    p route.activities.length 
    
    session[:main_route] = route
  end
  
  def addActivity
    route = session[:main_route]

    activity = Activity.new("amenity",params[:activity])
    Route.get_closest_activity(activity,route.start_point,route.end_point)

    #If activity list contains only spacer -> insert at 0
    #else insert at bevor last position
    if route.activities.length == 1
      route.activities.insert(0, activity)
    else        
      route.activities.insert(-2, activity) 
    end

    session[:main_route] = route
  end
end