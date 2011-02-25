class ActivityController < ApplicationController
  
  def updateActivity
    route = session[:main_route]

    activity = Activity.new("amenity",params[:activity])
    Route.get_closest_activity(activity,route.start_point,route.end_point)

    route.activities.push(activity)

    session[:main_route] = route
     
    respond_to do |format|      
     format.js
    end
  end
end