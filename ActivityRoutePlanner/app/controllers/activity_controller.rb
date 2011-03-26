class ActivityController < ApplicationController
  
  #method is called on a action of each 
  #activity
  def update_activity
    route = Route.find(session[:main_route])
    #activity = Activity.new("","")#dummy activity
    
    #add or update activity  
    if params[:activity]
      id = params[:id].to_i
      activity = Activity.find(id)
      if activity!= nil       
          activity.update_activity(route, params[:activity])
      else
        @new_activity = Activity.new()
        splitted = params[:activity].split("$")
        @new_activity.tag = splitted[0]
        @new_activity.value = splitted[1]
        @new_activity.route = route
        @new_activity.save
      end      
    elsif params[:delete_activity]
      index = params[:delete_activity].to_i
      activity = Activity.find(index)      
      activity.destroy
    end    
      
    respond_to do |format|      
      format.js
    end
  end


end