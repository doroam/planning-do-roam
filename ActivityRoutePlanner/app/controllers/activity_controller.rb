class ActivityController < ApplicationController
  
  def updateActivity
    route = session[:main_route] 
  
    if params[:activity]
      id = params[:id].to_i
      if id < route.activities.length-1
        route = changeActivity(params[:activity], id, route)
      else
        route = addActivity(route, params[:activity])
      end      
    elsif params[:deleteActivity]
      route =  deleteActivity(route, params[:deleteActivity])    
    end
     
    session[:main_route] = route
      
    respond_to do |format|      
      format.js
    end
  end
  
  #delete activity from list
  def deleteActivity(route, index)
    activity          = route.activities[index.to_i]
    route.activities.delete_at index.to_i
    return route
  end
  
  #add activity to list
  def addActivity(route, act)   
    activity = create(route, act)

    #If activity list contains only spacer -> insert at 0
    #else insert at bevor last position
    if route.activities.length == 1
      route.activities.insert(0, activity)
    else        
      route.activities.insert(-2, activity) 
    end

    return route
  end
  
  #change activity
  def changeActivity(act, id, route)
    activity = create(route, act)
    route.activities[id] = activity
    return route
  end
  
  def create(route, act)
    activity = Activity.new("amenity",act)
    Route.get_closest_activity(activity,route.start_point,route.end_point)
    return activity
  end
end