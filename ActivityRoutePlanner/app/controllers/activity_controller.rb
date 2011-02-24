class ActivityController < ApplicationController
  
  def update_activity
    route = session[:main_route]
    
    route.activities.push(Activity.new("amenity",params[:activity]))
     
    respond_to do |format|      
     format.js {render :partial => 'route/routeForm' }
    end
  end
end