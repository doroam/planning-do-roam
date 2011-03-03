class ActivityController < ApplicationController
  
  #method is called on a action of each 
  #activity
  def updateActivity
    route = session[:main_route] 
    activity = Activity.new("","")#dummy activity
    
    #add or update activity  
    if params[:activity]
      id = params[:id].to_i
      if id < route.activities.length-1
        if !activity.changeActivity(route, params[:activity], id)
           flash[:error] = "Activity could not change!"
        end
      else
        if !activity.addActivity(route, params[:activity])
           flash[:error] = "Activity was not found!"
        end
      end      
    elsif params[:deleteActivity]
      index = params[:deleteActivity].to_i
      params[:deleteActivity] = route.activities[index].get_image_id()
      if !activity.deleteActivity(route, index)
           flash[:error] = "Activity could not deleted!"
      end
    end
     
    session[:main_route] = route
      
    respond_to do |format|      
      format.js
    end
  end
end