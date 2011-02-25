class ActivityController < ApplicationController
  
  def updateActivity
    route = session[:main_route]
    
    route.activities.push(Activity.new("amenity",params[:activity]))
    
     
    respond_to do |format|      
     format.js 
    end
  end
end